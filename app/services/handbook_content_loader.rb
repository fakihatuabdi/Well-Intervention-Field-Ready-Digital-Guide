# Loads handbook articles from the Markdown files in db/handbook into the
# database.
#
# Safe to run many times (on every deploy, from db:seed or `rails handbook:load`):
# - creates articles that do not exist yet,
# - replaces the old "coming soon" placeholder articles with real content,
# - refreshes articles it wrote earlier when the Markdown file changed,
# - NEVER overwrites an article that someone edited after it was loaded,
# - NEVER deletes anything (bookmarks and view counts stay intact).
#
# File format (one article per file):
#
#   ---
#   title: Artificial Lift
#   slug: gk-artificial-lift
#   position: 13
#   summary: One sentence shown on cards and search results.
#   ---
#   Markdown body...
require "digest"
require "yaml"

class HandbookContentLoader
  ROOT = Rails.root.join("db", "handbook")

  # Folder name => where its articles live in the app
  SECTIONS = {
    "general_knowledge" => { category: "general_knowledge", subcategory: nil },
    "zona_rokan" => { category: "zona_rokan", subcategory: "rig_hub" }
  }.freeze

  # Text that identifies the old placeholder articles from the first seed
  PLACEHOLDER_MARKERS = [
    "Comprehensive Content in Development",
    "Content will be added soon"
  ].freeze

  Entry = Struct.new(:path, :title, :slug, :position, :summary, :body, :category, :subcategory, keyword_init: true) do
    def digest
      HandbookContentLoader.digest(body)
    end
  end

  Result = Struct.new(:created, :updated, :unchanged, :skipped, :retired, keyword_init: true) do
    def to_s
      "created: #{created.size}, updated: #{updated.size}, unchanged: #{unchanged.size}, " \
        "kept (edited by a user): #{skipped.size}, placeholders hidden: #{retired.size}"
    end
  end

  class InvalidFile < StandardError; end

  def self.digest(text)
    Digest::SHA256.hexdigest(text.to_s.strip)
  end

  def self.load!(root: ROOT, logger: nil)
    new(root: root, logger: logger).load!
  end

  def initialize(root: ROOT, logger: nil)
    @root = Pathname.new(root)
    @logger = logger
  end

  # Parses every Markdown file. Raises InvalidFile with the file name when a
  # file is broken, before anything is written to the database.
  def entries
    @entries ||= begin
      list = SECTIONS.flat_map do |folder, placement|
        Dir.glob(@root.join(folder, "*.md").to_s).sort.map { |path| parse(path, placement) }
      end
      duplicates = list.group_by(&:slug).select { |_slug, items| items.size > 1 }.keys
      raise InvalidFile, "Duplicate slug(s): #{duplicates.join(', ')}" if duplicates.any?

      list
    end
  end

  def load!
    result = Result.new(created: [], updated: [], unchanged: [], skipped: [], retired: [])
    list = entries
    touched_ids = []

    Article.transaction do
      list.each do |entry|
        article = find_existing(entry)

        if article.nil?
          article = Article.create!(attributes_for(entry))
          result.created << article.title
        elsif up_to_date?(article, entry)
          result.unchanged << article.title
        elsif managed_by_loader?(article)
          article.update!(attributes_for(entry))
          result.updated << article.title
        else
          result.skipped << article.title
        end

        touched_ids << article.id
      end

      # Hide leftover placeholder articles that no file replaces
      Article.where.not(id: touched_ids).find_each do |article|
        next unless article.published? && placeholder?(article.content)

        article.update!(published: false)
        result.retired << article.title
      end
    end

    log("Handbook content loaded (#{result})")
    result.skipped.each { |title| log("  kept as edited: #{title}") }
    result
  end

  def placeholder?(content)
    text = content.to_s
    text.strip.empty? || PLACEHOLDER_MARKERS.any? { |marker| text.include?(marker) }
  end

  private

  def parse(path, placement)
    raw = File.read(path, encoding: "UTF-8")
    match = raw.match(/\A---\s*\n(.*?)\n---\s*\n(.*)\z/m)
    raise InvalidFile, "#{relative(path)}: missing front matter (--- ... ---)" unless match

    meta = YAML.safe_load(match[1]) || {}
    raise InvalidFile, "#{relative(path)}: front matter must be key: value pairs" unless meta.is_a?(Hash)

    title = meta["title"].to_s.strip
    slug = meta["slug"].to_s.strip
    body = match[2].strip
    raise InvalidFile, "#{relative(path)}: title is required" if title.empty?
    raise InvalidFile, "#{relative(path)}: slug is required" if slug.empty?
    raise InvalidFile, "#{relative(path)}: slug may only use a-z, 0-9 and -" unless slug.match?(/\A[a-z0-9-]+\z/)
    raise InvalidFile, "#{relative(path)}: article body is empty" if body.empty?

    Entry.new(
      path: path,
      title: title,
      slug: slug,
      position: Integer(meta["position"] || 0),
      summary: meta["summary"].to_s.strip.presence,
      body: body,
      category: placement[:category],
      subcategory: placement[:subcategory]
    )
  rescue Psych::SyntaxError, ArgumentError, TypeError => e
    raise InvalidFile, "#{relative(path)}: #{e.message}"
  end

  # Match by slug first; fall back to the title the first seed used, so the
  # old placeholder article (and its bookmarks / view count) is reused.
  def find_existing(entry)
    Article.find_by(slug: entry.slug) ||
      Article.find_by(category: entry.category, subcategory: entry.subcategory, title: entry.title)
  end

  def attributes_for(entry)
    {
      title: entry.title,
      slug: entry.slug,
      category: entry.category,
      subcategory: entry.subcategory,
      position: entry.position,
      summary: entry.summary,
      content: entry.body,
      seed_digest: entry.digest,
      published: true
    }
  end

  def up_to_date?(article, entry)
    article.seed_digest == entry.digest &&
      self.class.digest(article.content) == entry.digest &&
      article.title == entry.title &&
      article.slug == entry.slug &&
      article.position == entry.position &&
      article.summary == entry.summary
  end

  # True when nobody changed the article since the loader (or the first seed)
  # wrote it, so replacing it does not lose anyone's work.
  def managed_by_loader?(article)
    return true if placeholder?(article.content)
    return false if article.seed_digest.blank?

    self.class.digest(article.content) == article.seed_digest
  end

  def relative(path)
    Pathname.new(path).relative_path_from(Rails.root).to_s
  rescue ArgumentError
    path.to_s
  end

  def log(message)
    if @logger
      @logger.respond_to?(:info) ? @logger.info(message) : @logger.puts(message)
    else
      Rails.logger.info(message)
    end
  end
end

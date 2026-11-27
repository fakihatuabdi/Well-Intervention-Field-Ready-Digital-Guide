module ArticlesHelper
  ALLOWED_TAGS = %w[
    h2 h3 h4 h5 p br hr ul ol li strong em b i del code pre blockquote a
    table thead tbody tfoot tr th td sup sub span img
  ].freeze
  ALLOWED_ATTRIBUTES = %w[href id title colspan rowspan src alt].freeze
  # Only images shipped with the app are shown (see public/handbook-images)
  IMAGE_PATH_PREFIX = "/handbook-images/".freeze

  RenderedArticle = Struct.new(:html, :toc, keyword_init: true)

  # Turns an article's Markdown into safe HTML plus a table of contents
  # (the level-2 headings). Old plain-text articles render as paragraphs.
  def rendered_article(article)
    cache_key = ["article-html/v2", article.id, article.updated_at&.to_i, ArticlesHelper.content_digest(article.content)]
    data = Rails.cache.fetch(cache_key) { ArticlesHelper.render_markdown(article.content) }
    RenderedArticle.new(html: data[:html].to_s.html_safe, toc: data[:toc] || [])
  rescue StandardError => e
    Rails.logger.error("Article #{article&.id} could not be rendered: #{e.class}: #{e.message}")
    RenderedArticle.new(html: simple_format(article&.content.to_s), toc: [])
  end

  # Plain-text preview for cards, search results and bookmarks
  def article_excerpt(article, length: 160)
    text = article.summary.presence || ArticlesHelper.plain_text(article.content)
    truncate(text.to_s, length: length, separator: " ")
  end

  def self.content_digest(content)
    Digest::SHA1.hexdigest(content.to_s)
  end

  def self.render_markdown(markdown)
    raw_html = Kramdown::Document.new(
      markdown.to_s,
      input: "GFM",
      hard_wrap: false,
      auto_ids: true,
      auto_id_prefix: "bagian-",
      syntax_highlighter: nil
    ).to_html

    safe_html = Rails::HTML5::SafeListSanitizer.new.sanitize(
      raw_html, tags: ALLOWED_TAGS, attributes: ALLOWED_ATTRIBUTES
    )

    fragment = Nokogiri::HTML5.fragment(safe_html)
    # Wide tables scroll sideways on phones instead of breaking the layout
    fragment.css("table").each { |table| table.wrap('<div class="table-wrap"></div>') }
    build_figures(fragment)
    # Links leave the app in a new tab
    fragment.css("a[href]").each do |link|
      next if link["href"].to_s.start_with?("#", "/")

      link["target"] = "_blank"
      link["rel"] = "noopener noreferrer"
    end

    toc = fragment.css("h2[id]").map { |h| { id: h["id"], title: h.text.strip } }
    { html: fragment.to_html, toc: toc }
  end

  # Images become <figure> blocks with a caption (from the alt text) that open
  # the full-size picture when tapped. Images from anywhere else are dropped.
  def self.build_figures(fragment)
    fragment.css("img").each do |img|
      src = img["src"].to_s
      unless src.start_with?(IMAGE_PATH_PREFIX) && !src.include?("..")
        img.remove
        next
      end

      caption = img["alt"].to_s.strip
      img["loading"] = "lazy"
      img["decoding"] = "async"

      figure = Nokogiri::XML::Node.new("figure", fragment.document)
      figure["class"] = "article-figure"
      link = Nokogiri::XML::Node.new("a", fragment.document)
      link["href"] = src
      link["target"] = "_blank"
      link["rel"] = "noopener"
      link["title"] = "Buka gambar ukuran penuh"
      figure.add_child(link)

      parent = img.parent
      if parent&.name == "p" && parent.children.all? { |n| n == img || (n.text? && n.text.strip.empty?) }
        parent.replace(figure)
      else
        img.replace(figure)
      end
      link.add_child(img)

      next if caption.empty?

      figcaption = Nokogiri::XML::Node.new("figcaption", fragment.document)
      figcaption.content = caption
      figure.add_child(figcaption)
    end
  end

  def self.plain_text(markdown)
    markdown.to_s
      .gsub(/^\s*\|?[-:| ]+\|\s*$/, " ")   # table separator rows
      .gsub(/!\[[^\]]*\]\([^)]*\)/, " ")   # images
      .gsub(/[#>*_`|]/, " ")
      .gsub(/\[([^\]]*)\]\([^)]*\)/, '\1')
      .squish
  end
end

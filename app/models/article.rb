class Article < ApplicationRecord
  # Note: pg_search is for PostgreSQL. Using simple LIKE queries so the same
  # code works on SQLite (development) and PostgreSQL (production).

  CATEGORY_LABELS = {
    "general_knowledge" => "General Knowledge",
    "zona_rokan" => "Zona Rokan Operation"
  }.freeze

  has_many :bookmarks, dependent: :destroy

  validates :title, presence: true
  validates :category, presence: true
  validates :slug, presence: true, uniqueness: true

  before_validation :generate_slug, on: :create
  after_initialize :set_defaults

  # Simple search compatible with SQLite and PostgreSQL. User input is escaped
  # so characters like % and _ are searched literally.
  scope :search_by_all, ->(query) {
    terms = query.to_s.downcase.split.first(10)
    next all if terms.empty?

    clause = "(LOWER(title) LIKE :t OR LOWER(content) LIKE :t OR LOWER(category) LIKE :t " \
             "OR LOWER(subcategory) LIKE :t OR LOWER(summary) LIKE :t)"
    terms.reduce(all) do |scope, term|
      scope.where(clause, t: "%#{sanitize_sql_like(term)}%")
    end
  }

  scope :published, -> { where(published: true) }
  scope :by_category, ->(category) { where(category: category) }
  scope :by_subcategory, ->(subcategory) { where(subcategory: subcategory) }
  scope :in_reading_order, -> { order(:position, :title) }
  scope :popular, -> { order(view_count: :desc).limit(5) }

  def category_label
    CATEGORY_LABELS.fetch(category.to_s) { category.to_s.tr("_", " ").titleize }
  end

  def zona_rokan?
    category == "zona_rokan"
  end

  # Thread-safe increment using a database-level update
  def increment_view_count!
    self.class.update_counters(id, view_count: 1)
    reload
  end

  private

  def generate_slug
    return if slug.present?

    base_slug = title.to_s.parameterize.presence || "article"
    candidate = base_slug
    counter = 1
    while Article.where(slug: candidate).where.not(id: id).exists?
      candidate = "#{base_slug}-#{counter}"
      counter += 1
    end
    self.slug = candidate
  end

  # Guarded so queries that select only some columns do not raise
  # ActiveModel::MissingAttributeError.
  def set_defaults
    self.view_count ||= 0 if has_attribute?(:view_count)
    self.published = false if has_attribute?(:published) && published.nil?
  end
end

class Article < ApplicationRecord
  # Note: pg_search is for PostgreSQL. Using simple LIKE queries for SQLite compatibility
  # include PgSearch::Model
  
  has_many :bookmarks, dependent: :destroy
  
  validates :title, presence: true
  validates :category, presence: true
  validates :slug, presence: true, uniqueness: true
  
  before_validation :generate_slug, on: :create
  after_initialize :set_defaults
  
  # Simple search compatible with SQLite
  scope :search_by_all, ->(query) {
    return all if query.blank?
    
    terms = query.downcase.split
    where(
      terms.map { |term|
        "(LOWER(title) LIKE ? OR LOWER(content) LIKE ? OR LOWER(category) LIKE ? OR LOWER(subcategory) LIKE ?)"
      }.join(" AND "),
      *terms.flat_map { |term| ["%#{term}%", "%#{term}%", "%#{term}%", "%#{term}%"] }
    )
  }
  
  scope :published, -> { where(published: true) }
  scope :by_category, ->(category) { where(category: category) }
  scope :by_subcategory, ->(subcategory) { where(subcategory: subcategory) }
  scope :popular, -> { order(view_count: :desc).limit(5) }
  
  def increment_view_count
    increment!(:view_count)
  end
  
  private
  
  def generate_slug
    return if slug.present?
    base_slug = title.parameterize if title.present?
    self.slug = base_slug
    
    # Handle duplicate slugs
    counter = 1
    while Article.where(slug: self.slug).where.not(id: self.id).exists?
      self.slug = "#{base_slug}-#{counter}"
      counter += 1
    end
  end
  
  def set_defaults
    self.view_count ||= 0
    self.published ||= false
  end
end

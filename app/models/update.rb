class Update < ApplicationRecord
  validates :title, presence: true
  
  scope :recent, -> { order(published_at: :desc).limit(5) }
  scope :published, -> { where('published_at <= ?', Time.current) }
end

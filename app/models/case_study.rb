class CaseStudy < ApplicationRecord
  validates :title, presence: true
  
  scope :published, -> { where(published: true) }
  scope :recent, -> { order(created_at: :desc).limit(3) }
end

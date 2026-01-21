class Bookmark < ApplicationRecord
  belongs_to :article
  belongs_to :user, optional: true # Optional until authentication is enforced
  
  validates :article_id, presence: true
  
  # Ensure unique bookmark per user per article
  validates :article_id, uniqueness: { scope: :user_id }, if: -> { user_id.present? }
end

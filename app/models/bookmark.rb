class Bookmark < ApplicationRecord
  belongs_to :article
  belongs_to :user, optional: true # Anonymous visitors are identified by session_id

  validates :article_id, presence: true
  validates :session_id, presence: true, if: -> { user_id.blank? }

  # One bookmark per article per owner (user or browser session)
  validates :article_id, uniqueness: { scope: [:user_id, :session_id] }
end

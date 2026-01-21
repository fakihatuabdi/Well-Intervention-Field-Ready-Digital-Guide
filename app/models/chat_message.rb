class ChatMessage < ApplicationRecord
  belongs_to :user, optional: true
  
  validates :message, presence: true
  validates :role, presence: true, inclusion: { in: %w[user assistant] }
  
  # Ensure either user_id or session_id is present
  validates :session_id, presence: true, unless: -> { user_id.present? }
  
  scope :for_user, ->(user) { where(user: user).order(created_at: :asc) }
  scope :for_session, ->(session_id) { where(session_id: session_id).order(created_at: :asc) }
  scope :recent, ->(limit = 50) { order(created_at: :desc).limit(limit) }
end

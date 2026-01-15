class Bookmark < ApplicationRecord
  belongs_to :article
  
  validates :article_id, presence: true
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # Associations
  has_many :bookmarks, dependent: :destroy
  has_many :chat_messages, dependent: :destroy
  has_many :bookmarked_articles, through: :bookmarks, source: :article
end

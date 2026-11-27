class AddHandbookFieldsToArticles < ActiveRecord::Migration[7.1]
  def change
    # Display order inside a handbook section
    add_column :articles, :position, :integer, default: 0, null: false
    # Short description shown on article cards and search results
    add_column :articles, :summary, :string
    # Fingerprint of the content written by the handbook loader. When the
    # current content still matches it, the loader may refresh the article;
    # when someone edited the article, the loader leaves it alone.
    add_column :articles, :seed_digest, :string
    add_index :articles, [:category, :subcategory, :position]

    # Anonymous visitors get their own bookmarks instead of sharing one list
    add_column :bookmarks, :session_id, :string
    add_index :bookmarks, :session_id
    add_index :bookmarks, :user_id
    add_index :bookmarks, :article_id
  end
end

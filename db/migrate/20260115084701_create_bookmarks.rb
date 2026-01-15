class CreateBookmarks < ActiveRecord::Migration[7.1]
  def change
    create_table :bookmarks do |t|
      t.integer :user_id
      t.integer :article_id
      t.text :last_position

      t.timestamps
    end
  end
end

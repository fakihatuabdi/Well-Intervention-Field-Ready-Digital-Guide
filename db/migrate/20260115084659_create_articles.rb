class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :category
      t.string :subcategory
      t.text :content
      t.string :slug
      t.boolean :published, default: false
      t.integer :view_count, default: 0

      t.timestamps
    end
    
    add_index :articles, :slug, unique: true
    add_index :articles, :category
    add_index :articles, :published
  end
end

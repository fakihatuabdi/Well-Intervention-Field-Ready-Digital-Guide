class CreateUpdates < ActiveRecord::Migration[7.1]
  def change
    create_table :updates do |t|
      t.string :title
      t.text :content
      t.datetime :published_at
      t.string :category

      t.timestamps
    end
  end
end

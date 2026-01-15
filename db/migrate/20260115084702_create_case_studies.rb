class CreateCaseStudies < ActiveRecord::Migration[7.1]
  def change
    create_table :case_studies do |t|
      t.string :title
      t.text :description
      t.text :content
      t.boolean :published

      t.timestamps
    end
  end
end

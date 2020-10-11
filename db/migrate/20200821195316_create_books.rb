class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.decimal :price, precision: 8, scale: 2, null: false
      t.text :description
      t.integer :publication_year
      t.float :width, scale: 2
      t.float :height, scale: 2
      t.float :depth, scale: 2
      t.string :materials
      t.belongs_to :category, foreign_key: { to_table: :categories }
      t.string :title_image, null: true
      t.json :images, null: true

      t.timestamps
    end
  end
end

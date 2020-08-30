class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.integer :quantity, null: false
      t.belongs_to :book, null: false
      t.belongs_to :cart

      t.timestamps
    end
  end
end

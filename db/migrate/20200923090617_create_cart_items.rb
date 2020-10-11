class CreateCartItems < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_items do |t|
      t.integer :amount, default: 1
      t.belongs_to :cart, foreign_key: { to_table: :carts }
      t.belongs_to :book, foreign_key: { to_table: :books }

      t.timestamps
    end
  end
end

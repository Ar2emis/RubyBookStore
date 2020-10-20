class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.integer :amount, default: 1
      t.belongs_to :order, foreign_key: { to_table: :orders }
      t.belongs_to :book, foreign_key: { to_table: :books }

      t.timestamps
    end
  end
end

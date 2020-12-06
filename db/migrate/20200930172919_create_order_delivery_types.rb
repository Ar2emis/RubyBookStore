class CreateOrderDeliveryTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :order_delivery_types do |t|
      t.belongs_to :order, foreign_key: { to_table: :orders }
      t.belongs_to :delivery_type, foreign_key: { to_table: :delivery_types }

      t.timestamps
    end
  end
end

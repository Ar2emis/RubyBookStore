class CreateOrderCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :order_coupons do |t|
      t.belongs_to :order, foreign_key: { to_table: :orders }
      t.belongs_to :coupon, foreign_key: { to_table: :coupons }

      t.timestamps
    end
  end
end

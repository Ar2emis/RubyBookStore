class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.belongs_to :user, foreign_key: { to_table: :users }
      t.belongs_to :coupon, foreign_key: { to_table: :coupons }
      t.float :total_price, precision: 8, scale: 2
      t.string :state
      t.string :number, null: true
      t.date :completed_at, null: true

      t.timestamps
    end
  end
end

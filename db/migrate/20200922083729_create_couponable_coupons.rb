class CreateCouponableCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :couponable_coupons do |t|
      t.belongs_to :couponable, polymorphic: true
      t.belongs_to :coupon, foreign_key: { to_table: :coupons }

      t.timestamps
    end
  end
end

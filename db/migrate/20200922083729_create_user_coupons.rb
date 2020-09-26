class CreateUserCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :user_coupons do |t|
      t.belongs_to :user, foreign_key: { to_table: :users }
      t.belongs_to :coupon, foreign_key: { to_table: :coupons }

      t.timestamps
    end
  end
end

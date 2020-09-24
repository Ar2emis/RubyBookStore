class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.string :name, null: false
      t.decimal :sale, precision: 8, scale: 2, null: false
      t.string :code, null: false

      t.timestamps
    end
  end
end

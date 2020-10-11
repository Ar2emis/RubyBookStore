class CreateDeliveryTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_types do |t|
      t.string :name, null: false
      t.integer :min_days, null: false
      t.integer :max_days, null: false
      t.float :price, precision: 8, scale: 2, null: false

      t.timestamps
    end
  end
end

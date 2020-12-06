class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.belongs_to :user, foreign_key: { to_table: :users }
      t.integer :state
      t.string :number, null: true
      t.date :completed_at, null: true

      t.timestamps
    end
  end
end

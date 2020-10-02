class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.string :number, null: false
      t.string :name, null: false
      t.string :expiration_date, null: false
      t.string :cvv, null: false
      t.belongs_to :order, foreign_key: { to_table: :orders }      

      t.timestamps
    end
  end
end

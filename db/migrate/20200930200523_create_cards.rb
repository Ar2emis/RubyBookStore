class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.string :number
      t.string :name
      t.string :expiration_date
      t.string :cvv
      t.belongs_to :order, foreign_key: { to_table: :orders }      

      t.timestamps
    end
  end
end

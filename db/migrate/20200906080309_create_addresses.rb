class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :zip
      t.string :country
      t.string :phone
      t.integer :address_type
      t.belongs_to :user, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end

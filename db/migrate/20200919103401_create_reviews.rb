class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.belongs_to :book, foreign_key: { to_table: :books }, null: false
      t.integer :book_rate, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.belongs_to :user, foreign_key: { to_table: :users }
      t.integer :status, default: 0

      t.timestamps
    end
  end
end

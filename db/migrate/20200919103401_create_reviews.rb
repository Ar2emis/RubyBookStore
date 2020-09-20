class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.belongs_to :book, foreign_key: { to_table: :books }
      t.integer :book_rate
      t.string :title
      t.text :body
      t.date :date
      t.belongs_to :user, foreign_key: { to_table: :users }
      t.integer :status, default: 0

      t.timestamps
    end
  end
end

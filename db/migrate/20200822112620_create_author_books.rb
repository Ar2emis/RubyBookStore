class CreateAuthorBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :author_books do |t|
      t.belongs_to :author, foreign_key: { to_table: :authors }
      t.belongs_to :book, foreign_key: { to_table: :books }
    end
  end
end
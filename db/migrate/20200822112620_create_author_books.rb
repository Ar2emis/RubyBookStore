class CreateAuthorBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :author_books do |t|
      t.belongs_to :author
      t.belongs_to :book
    end
  end
end
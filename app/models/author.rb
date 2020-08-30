class Author < ApplicationRecord
  validates :first_name, :last_name, presence: true

  has_many :author_books, dependent: :destroy
  has_many :books, through: :author_books

  def full_name
    "#{first_name} #{last_name}"
  end
end

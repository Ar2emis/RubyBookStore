class Book < ApplicationRecord
  validates :title, presence: true
  validates :price, numericality: { greater_than: 0.0 }

  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books
  belongs_to :category

  scope :with_authors, -> { includes([:authors]) }
end

class Book < ApplicationRecord
  validates :title, presence: true
  validates :price, numericality: { greater_than: 0.0 }

  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books
  belongs_to :category

  scope :latest, -> { includes([:authors]).order(created_at: :desc) }

  def authors_names
    authors.map(&:full_name).join(', ')
  end
end

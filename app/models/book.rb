class Book < ApplicationRecord
  SORT_PARAMTERS = {
    newest: { created_at: :desc },
    cheap: :price,
    expensive: { price: :desc },
    atoz: :title,
    ztoa: { title: :desc }
  }.freeze

  validates :title, :price, presence: true
  validates :price, numericality: { greater_than: 0.0 }

  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books
  belongs_to :category

  scope :ordered, ->(order_type) { order(SORT_PARAMTERS.fetch(order_type, SORT_PARAMTERS[:newest])) }
end

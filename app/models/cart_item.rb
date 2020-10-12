class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :book

  validates :book, presence: true
  validates :amount, numericality: { greater_than: 0 }
end

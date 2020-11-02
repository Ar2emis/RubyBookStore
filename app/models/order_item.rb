class OrderItem < ApplicationRecord
  MIN_AMOUNT = 0
  belongs_to :order
  belongs_to :book

  validates :book, presence: true
  validates :quantity, numericality: { greater_than: MIN_AMOUNT }
end

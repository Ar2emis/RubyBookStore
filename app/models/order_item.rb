class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :book

  validates :book, presence: true
  validates :amount, numericality: { greater_than: 0 }, if: -> { amount.present? }
end

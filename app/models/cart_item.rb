class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :book

  validates :book, presence: true
  validates :count, numericality: { greater_than: 0 }, if: -> { count.present? }
end

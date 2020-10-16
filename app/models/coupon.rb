class Coupon < ApplicationRecord
  MIN_SALE = 0.0
  validates :name, :sale, :code, presence: true
  validates :sale, numericality: { greater_than_or_equal_to: MIN_SALE }
end

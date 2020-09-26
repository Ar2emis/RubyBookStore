class Coupon < ApplicationRecord
  validates :name, :sale, :code, presence: true
  validates :sale, numericality: { greater_than_or_equal_to: 0.0 }
end

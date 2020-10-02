class DeliveryType < ApplicationRecord
  validates :name, :min_days, :max_days, :price, presence: true
  validates :min_days, :max_days, :price, numericality: { greater_than_or_equal_to: 0 }
end

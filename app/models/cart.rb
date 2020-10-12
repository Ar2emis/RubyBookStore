class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy
  has_one :couponable_coupon, as: :couponable, dependent: :destroy
  has_one :coupon, through: :couponable_coupon
end

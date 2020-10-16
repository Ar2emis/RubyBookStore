class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy
  has_one :order_coupon, dependent: :destroy
  has_one :coupon, through: :order_coupon
end

class CouponableCoupon < ApplicationRecord
  belongs_to :couponable, polymorphic: true
  belongs_to :coupon
end

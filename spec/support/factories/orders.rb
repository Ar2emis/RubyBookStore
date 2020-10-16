FactoryBot.define do
  factory :order do
    order_items { [] }
    coupon {}
  end
end

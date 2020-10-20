FactoryBot.define do
  factory :order do
    state { :addresses }
    number { "R#{Array.new(8) { rand(10) }.join}" }
    completed_at { Time.zone.today }
    user {}
    order_items { [] }
    coupon {}
  end
end

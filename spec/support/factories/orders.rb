FactoryBot.define do
  factory :order do
    total_price { rand(10..100) }
    state { 'addresses' }
    number { 'R12345678' }
    completed_at { Time.zone.today }
    user { create(:user) }
    coupon { create(:coupon) }
  end
end

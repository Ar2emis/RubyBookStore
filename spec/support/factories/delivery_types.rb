FactoryBot.define do
  factory :delivery_type do
    name { Faker::Subscription.plan }
    min_days { rand(1..3) }
    max_days { rand(5..10) }
    price { rand(10) }
  end
end

FactoryBot.define do
  factory :coupon do
    name { Faker::Hipster.word.capitalize }
    sale { rand(1..10) }
    code { Devise.friendly_token[0, 5] }
    active { true }
  end
end

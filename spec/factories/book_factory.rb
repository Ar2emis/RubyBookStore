FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    price { Faker::Number.within(range: 1..10) }
    description { Faker::Lorem.paragraph_by_chars }
    association :category, factory: :category, strategy: :build
    authors { [association(:author), association(:author)] }
  end
end

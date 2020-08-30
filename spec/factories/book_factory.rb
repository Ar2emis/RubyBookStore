FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    price { 1 }
    association :category, factory: :category, strategy: :build
    authors { [association(:author), association(:author)] }
  end
end

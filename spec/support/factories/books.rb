FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    price { Faker::Number.within(range: 1..10) }
    description { Faker::Lorem.paragraph_by_chars }
    association :category, factory: :category, strategy: :create
    authors { Array.new(2) { create(:author) } }
    publication_year { rand(1900..2020) }
    width { Faker::Number.within(range: 5..10) }
    height { Faker::Number.within(range: 5..20) }
    depth { Faker::Number.within(range: 1..5) }
    materials { Array.new(3) { Faker::Construction.material }.join(', ') }
  end
end

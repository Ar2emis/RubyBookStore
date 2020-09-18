FactoryBot.define do
  factory :author do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    description { Faker::Lorem.paragraph_by_chars }
  end
end

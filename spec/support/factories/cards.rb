FactoryBot.define do
  factory :card do
    number { Faker::Finance.credit_card.delete('-') }
    name { Faker::Name.first_name }
    expiration_date { '12/34' }
    cvv { rand(100..9999) }
  end
end

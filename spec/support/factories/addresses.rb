FactoryBot.define do
  factory :address do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.first_name }
    address { 'Gogolya 3' }
    city { 'Dnipro' }
    zip { Faker::Address.zip }
    country { ISO3166::Country.all.sample.name }
    phone { "+#{ISO3166::Country.find_country_by_name(country).country_code}#{Faker::Number.number(digits: 9)}" }
    address_type { Address.address_types.keys.sample }
  end
end

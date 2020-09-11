FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    provider { 'facebook' }
    password { "#{Faker::Internet.password(min_length: 7, max_length: 15, mix_case: true)}1" }
    uid { Faker::Omniauth.facebook[:uid] }
  end
end

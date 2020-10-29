FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    provider { 'facebook' }
    password { "#{Faker::Internet.password(min_length: 7, max_length: 15, mix_case: true)}1" }
    uid { Faker::Omniauth.facebook[:uid] }
    confirmation_token { Devise.token_generator.generate(User, :confirmation_token)[1] }
    confirmed_at { Time.now.utc }
    cart { create(:order) }
  end
end

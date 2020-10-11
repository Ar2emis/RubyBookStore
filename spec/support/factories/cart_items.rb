FactoryBot.define do
  factory :cart_item do
    book { create(:book) }
    amount { 1 }
  end
end

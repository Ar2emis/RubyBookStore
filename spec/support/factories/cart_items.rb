FactoryBot.define do
  factory :cart_item do
    book { create(:book) }
    count { 1 }
  end
end

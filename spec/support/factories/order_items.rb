FactoryBot.define do
  factory :order_item do
    book { create(:book) }
    amount { 1 }
  end
end

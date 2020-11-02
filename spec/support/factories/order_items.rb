FactoryBot.define do
  factory :order_item do
    book { create(:book) }
    quantity { 1 }
  end
end

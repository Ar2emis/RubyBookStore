RSpec.describe OrderDecorator do
  subject(:decorator) { order.decorate }

  let(:order_items_amount) { 3 }
  let(:order) { create(:order) }
  let(:order_items) { create_list(:order_item, order_items_amount, order: order) }

  before do
    order.order_items = order_items
  end

  describe '#prepared_order_items' do
    it 'returns order items with books and images' do
      expect(decorator.prepared_order_items).to eq order_items
    end
  end

  describe '#subtotal' do
    it 'returns sum of order_items prices' do
      subtotal_price = order_items.inject(0) { |sum, item| sum + item.amount * item.book.price }
      expect(decorator.subtotal).to eq subtotal_price
    end
  end
end

RSpec.describe UpdateOrderItemService do
  describe '.call' do
    let(:order) { create(:order) }

    it 'returns instance of the service' do
      expect(described_class.call(params: {}, order: order)).to be_a described_class
    end

    context 'when no order item with choosed book' do
      let(:book) { create(:book) }

      it 'creates order item' do
        described_class.call(params: { book_id: book.id }, order: order)
        expect(order.order_items.count).not_to be_zero
      end
    end

    context 'when order item with choosed book exists' do
      let(:order_item_params) { attributes_for(:order_item) }

      it 'updates order item' do
        order.order_items.create(order_item_params)
        old_count = order.order_items.count
        described_class.call(params: { book_id: order_item_params[:book].id }, order: order)
        expect(order.order_items.count).to eq old_count
      end
    end

    context 'when deleting order item' do
      let(:order_item_params) { attributes_for(:order_item) }

      it 'deletes order item' do
        item = order.order_items.create(order_item_params)
        described_class.call(params: { delete_id: item.id }, order: order)
        expect(order.order_items.count).to be_zero
      end
    end
  end
end

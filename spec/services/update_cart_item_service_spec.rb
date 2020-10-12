RSpec.describe UpdateCartItemService do
  describe '.call' do
    let(:book_id) { create(:book).id }
    let(:cart) { create(:cart) }

    it 'returns instance of the service' do
      expect(described_class.call(cart_item_params: { book_id: book_id }, cart: cart)).to be_a described_class
    end

    it 'creates cart item' do
      described_class.call(cart_item_params: { book_id: book_id }, cart: cart)
      expect(cart.cart_items.count).not_to be_zero
    end
  end
end

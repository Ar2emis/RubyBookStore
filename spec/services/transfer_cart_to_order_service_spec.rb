RSpec.describe TransferCartToOrderService do
  describe '.call' do
    let(:cart) { create(:cart, user: create(:user)) }

    it 'returns instance of the service' do
      expect(described_class.call(cart: cart)).to be_a described_class
    end
  end

  describe '#order' do
    let(:cart) { create(:cart, user: create(:user)) }

    it 'contains converted cart to order' do
      service = described_class.call(cart: cart)
      expect(service.order).to be_a Order
    end
  end
end

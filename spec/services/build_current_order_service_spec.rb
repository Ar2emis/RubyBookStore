RSpec.describe BuildCurrentOrderService do
  describe '.call' do
    let(:cart) { create(:cart, user: create(:user)) }

    it 'returns instance of the service' do
      expect(described_class.call(cart: cart, session: {})).to be_a described_class
    end
  end

  describe '#order' do
    let(:cart) { create(:cart, user: create(:user)) }

    context 'when current order does not exist' do
      it 'returns order converted from cart' do
        service = described_class.call(cart: cart, session: {})
        expect(service.order).to be_a Order
      end
    end

    context 'when current order exists' do
      let(:order) { create(:order) }
      let(:session) { { order: order.id } }

      it 'returns current order' do
        service = described_class.call(cart: cart, session: session)
        expect(service.order).to eq order
      end
    end
  end
end

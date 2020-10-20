RSpec.describe BuildCheckoutOrderService do
  describe '.call' do
    let(:user) { create(:user) }

    it 'returns instance of the service' do
      expect(described_class.call(user: user, session: {})).to be_a described_class
    end
  end

  describe '#order' do
    context 'when user is not signed in or does not have current order and session does not contains order id' do
      it 'returns nil' do
        service = described_class.call(user: nil, session: {})
        expect(service.order).to be_nil
      end
    end

    context 'when user is signed in and have current order' do
      let(:user) { create(:user) }

      it 'returns current order' do
        service = described_class.call(user: user, session: {})
        expect(service.order).to eq user.current_order
      end
    end

    context 'when user is signed in and does not have current order but session contains order id' do
      let(:user) { create(:user, current_order: nil) }
      let(:order) { create(:order) }
      let(:session) { { current_order: order.id } }

      it 'returns current order' do
        service = described_class.call(user: user, session: session)
        expect(service.order).to eq order
      end
    end
  end
end

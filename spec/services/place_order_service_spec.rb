RSpec.describe PlaceOrderService do
  describe '.call' do
    let(:order) { create(:order, user: build(:user), delivery_type: build(:delivery_type), state: :confirm) }

    before do
      allow(OrderMailer).to receive(:order_complete_mail).and_call_original
      described_class.call(order: order)
    end

    it 'sets order number' do
      expect(order.number).to be_present
    end

    it 'sends order mail' do
      expect(OrderMailer).to have_received(:order_complete_mail)
    end

    it 'transfers order to complete state' do
      expect(order).to be_complete
    end
  end
end

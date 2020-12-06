RSpec.describe AddOrderPaymentService do
  describe '.call' do
    let(:order) { build(:order, state: :payment) }
    let(:params) { { card: attributes_for(:card), order: order } }

    before do
      described_class.call(params)
    end

    it 'sets payment' do
      expect(order.card).to be_present
    end

    it 'transfers order to confirm state' do
      expect(order).to be_confirm
    end
  end
end

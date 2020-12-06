RSpec.describe ChangeOrderStateService do
  describe '.call' do
    let(:order) { build(:order, state: :confirm) }
    let(:address_state) { :addresses }
    let(:delivery_state) { :delivery }
    let(:payment_state) { :payment }

    it 'transfers order to address state' do
      described_class.call(order: order, state: address_state)
      expect(order).to be_addresses
    end

    it 'transfers order to delivery state' do
      described_class.call(order: order, state: delivery_state)
      expect(order).to be_delivery
    end

    it 'transfers order to payment state' do
      described_class.call(order: order, state: payment_state)
      expect(order).to be_payment
    end
  end
end

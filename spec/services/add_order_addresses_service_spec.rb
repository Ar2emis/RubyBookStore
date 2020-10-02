RSpec.describe AddOrderAddressesService do
  describe '.call' do
    let(:order) { build(:order, state: :addresses) }
    let(:billing_address) { attributes_for(:address).except(:type) }

    before do
      described_class.call(only_billing: '1', billing_address: billing_address, order: order)
    end

    it 'sets order billing address' do
      expect(order.billing_address).to be_present
    end

    it 'sets order shipping address' do
      expect(order.shipping_address).to be_present
    end

    it 'transfers order to delivery state' do
      expect(order).to be_delivery
    end
  end
end

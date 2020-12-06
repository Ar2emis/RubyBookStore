RSpec.describe AddOrderAddressesService do
  describe '.call' do
    let(:order) { create(:order, state: :addresses) }
    let(:billing_address) { attributes_for(:address, address_type: :billing) }

    context 'when only billing address' do
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

    context 'when shipping and billing addresses' do
      let(:shipping_address) { attributes_for(:address, address_type: :shipping) }

      before do
        described_class.call(shipping_address: shipping_address, billing_address: billing_address, order: order)
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
end

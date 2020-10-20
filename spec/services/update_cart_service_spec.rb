RSpec.describe UpdateCartService do
  describe '.call' do
    let(:order) { create(:order) }

    it 'returns instance of the service' do
      expect(described_class.call(params: {}, order: order)).to be_a described_class
    end

    context 'when order item updates' do
      let(:order_item_params) { attributes_for(:order_item) }

      it 'calls UpdateOrderItemService' do
        allow(UpdateOrderItemService).to receive(:call)
        described_class.call(params: { order_item: order_item_params }, order: order)
        expect(UpdateOrderItemService).to have_received(:call)
      end
    end

    context 'when coupon updates' do
      let(:coupon_code) { '123456' }

      it 'calls AddCouponService' do
        allow(AddCouponService).to receive(:call)
        described_class.call(params: { coupon: { code: coupon_code } }, order: order)
        expect(AddCouponService).to have_received(:call)
      end
    end
  end

  describe '#success?' do
    let(:order) { create(:order) }

    context 'when service successeded' do
      subject(:service) { described_class.call(params: {}, order: order) }

      it 'returns true' do
        expect(service).to be_success
      end
    end

    context 'when service failed' do
      subject(:service) { described_class.call(params: { coupon: { code: '' } }, order: order) }

      it 'returns false' do
        expect(service).not_to be_success
      end
    end
  end
end

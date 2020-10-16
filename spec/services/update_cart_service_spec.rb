RSpec.describe UpdateCartService do
  describe '.call' do
    let(:order) { create(:order) }

    it 'returns instance of the service' do
      expect(described_class.call(params: {}, order: order)).to be_a described_class
    end

    context 'when order item updates' do
      let(:order_item_params) { attributes_for(:order_item) }

      it 'creates order item' do
        described_class.call(params: { order_item: order_item_params }, order: order)
        expect(order.order_items.count).not_to be_zero
      end
    end

    context 'when coupon updates' do
      let(:coupon) { create(:coupon) }

      it 'assigns coupon to order' do
        described_class.call(params: { coupon: { code: coupon.code } }, order: order)
        expect(order.coupon).to eq coupon
      end
    end
  end

  describe '#success?' do
    let(:order) { create(:order) }

    context 'when service successeded' do
      subject(:service) { described_class.call(params: {}, order: order) }

      let(:coupon) { create(:coupon) }

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

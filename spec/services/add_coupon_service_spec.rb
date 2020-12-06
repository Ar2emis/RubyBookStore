RSpec.describe AddCouponService do
  describe '.call' do
    let(:order) { create(:order) }
    let(:coupon) { create(:coupon) }

    it 'returns instance of the service' do
      expect(described_class.call(params: { code: coupon.code }, order: order)).to be_a described_class
    end

    context 'when coupon updates' do
      before do
        described_class.call(params: { code: coupon.code }, order: order)
      end

      it 'assigns coupon to order' do
        expect(order.coupon).to eq coupon
      end

      it 'deactivates coupon' do
        coupon.reload
        expect(coupon).not_to be_active
      end
    end
  end
end

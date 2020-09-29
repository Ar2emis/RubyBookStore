RSpec.describe AddCouponService do
  describe '.call' do
    let(:coupon) { create(:coupon) }
    let(:cart) { create(:cart) }

    it 'returns instance of the service' do
      expect(described_class.call(coupon: coupon, cart: cart)).to be_a described_class
    end
  end

  describe '#success?' do
    let(:cart) { create(:cart) }

    context 'when service successeded' do
      subject(:service) { described_class.call(coupon: coupon, cart: cart) }

      let(:coupon) { create(:coupon) }

      it 'returns true' do
        expect(service).to be_success
      end
    end

    context 'when service failed' do
      subject(:service) { described_class.call(coupon: nil, cart: cart) }

      it 'returns false' do
        expect(service).not_to be_success
      end
    end
  end
end

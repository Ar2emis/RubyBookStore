RSpec.describe CartDecorator do
  subject(:decorator) { cart.decorate }

  let(:cart_items_amount) { 3 }
  let(:cart) { create(:cart) }
  let(:cart_items) { create_list(:cart_item, cart_items_amount, cart: cart) }

  before do
    cart.cart_items = cart_items
  end

  describe '#ordered_cart_items' do
    it 'returns cart items ordered by creation date' do
      ordered_cart_items = cart_items.sort_by(&:created_at)
      expect(decorator.ordered_cart_items).to eq ordered_cart_items
    end
  end

  describe '#subtotal' do
    it 'returns sum of cart_items prices' do
      subtotal_price = cart_items.inject(0) { |sum, item| sum + item.amount * item.book.price }
      expect(decorator.subtotal).to eq subtotal_price
    end
  end

  describe '#discount' do
    let(:coupon) { create(:coupon) }

    it 'returns sale of the coupon if coupon exists' do
      cart.coupon = coupon
      expect(decorator.discount).to eq coupon.sale
    end

    it 'returns 0.0 of the coupon if coupon does not exist' do
      expect(decorator.discount).to be_zero
    end
  end

  describe '#total_price' do
    let(:coupon) { create(:coupon) }

    it 'returns sum of cart_items with coupon sale' do
      cart.coupon = coupon
      total_price = cart_items.inject(0) { |sum, item| sum + item.amount * item.book.price } - coupon.sale
      expect(decorator.total_price).to eq total_price
    end
  end
end

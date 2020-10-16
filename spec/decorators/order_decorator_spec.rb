RSpec.describe OrderDecorator do
  subject(:decorator) { order.decorate }

  let(:order_items_amount) { 3 }
  let(:order) { create(:order) }
  let(:order_items) { create_list(:order_item, order_items_amount, order: order) }

  before do
    order.order_items = order_items
  end

  describe '#ordered_order_items' do
    it 'returns order items ordered by creation date' do
      ordered_order_items = order_items.sort_by(&:created_at)
      expect(decorator.ordered_order_items).to eq ordered_order_items
    end
  end

  describe '#subtotal_price' do
    it 'returns sum of order_items prices' do
      subtotal_price = order_items.inject(0) { |sum, item| sum + item.amount * item.book.price }
      expect(decorator.subtotal_price).to eq subtotal_price
    end
  end

  describe '#coupon_sale' do
    let(:coupon) { create(:coupon) }

    it 'returns sale of the coupon if coupon exists' do
      order.coupon = coupon
      expect(decorator.coupon_sale).to eq coupon.sale
    end

    it 'returns 0.0 of the coupon if coupon does not exist' do
      expect(decorator.coupon_sale).to be_zero
    end
  end

  describe '#total_price' do
    let(:coupon) { create(:coupon) }

    it 'returns sum of order_items with coupon sale' do
      order.coupon = coupon
      total_price = order_items.inject(0) { |sum, item| sum + item.amount * item.book.price } - coupon.sale
      expect(decorator.total_price).to eq total_price
    end
  end
end

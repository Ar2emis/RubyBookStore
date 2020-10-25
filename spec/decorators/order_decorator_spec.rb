RSpec.describe OrderDecorator do
  subject(:decorator) { order.decorate }

  let(:order_items_amount) { 3 }
  let(:order) { create(:order, state: :confirm) }
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

  describe '#subtotal' do
    it 'returns sum of order_items prices' do
      subtotal = order_items.inject(0) { |sum, item| sum + item.amount * item.book.price }
      expect(decorator.subtotal).to eq subtotal
    end
  end

  describe '#discount' do
    let(:coupon) { create(:coupon) }

    it 'returns sale of the coupon if coupon exists' do
      order.coupon = coupon
      expect(decorator.discount).to eq coupon.sale
    end

    it 'returns 0.0 of the coupon if coupon does not exist' do
      expect(decorator.discount).to be_zero
    end
  end

  describe '#total_price' do
    let(:coupon) { create(:coupon) }
    let(:delivery) { create(:delivery_type) }

    it 'returns sum of order_items with coupon sale and delivery price' do
      order.coupon = coupon
      order.delivery_type = delivery
      total = order_items.inject(0) { |sum, item| sum + item.amount * item.book.price } + delivery.price - coupon.sale
      expect(decorator.total_price).to eq total
    end
  end

  describe '#delivery_price' do
    let(:delivery) { create(:delivery_type) }

    it 'returns delivery price if delivery exists' do
      order.delivery_type = delivery
      expect(decorator.delivery_price).to eq delivery.price
    end

    it 'returns 0.0 of the coupon if coupon does not exist' do
      expect(decorator.delivery_price).to be_zero
    end
  end

  describe '#formated_updated_at' do
    let(:expected_format) { order.updated_at.strftime('%B %d, %Y') }

    it 'formats updated at date' do
      expect(decorator.formated_updated_at).to eq expected_format
    end
  end

  describe '#state_done?' do
    let(:completed_step) { :addresses }
    let(:uncompleted_step) { :complete }

    it 'returns true if state already done' do
      expect(decorator).to be_state_done(completed_step)
    end

    it 'returns false if state does not completed' do
      expect(decorator).not_to be_state_done(uncompleted_step)
    end
  end

  describe '#current_state?' do
    let(:not_current_state) { :not_current_state }

    it 'returns true if passed state is current' do
      expect(decorator).to be_current_state(decorator.state)
    end

    it 'returns false if passed state is not current' do
      expect(decorator).not_to be_current_state(not_current_state)
    end
  end
end

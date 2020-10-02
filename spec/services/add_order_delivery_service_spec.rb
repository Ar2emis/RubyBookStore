RSpec.describe AddOrderDeliveryService do
  describe '.call' do
    let(:total_price) { 10 }
    let(:order) { build(:order, total_price: total_price, state: :delivery) }
    let(:delivery) { create(:delivery_type) }

    before do
      described_class.call(order: order, delivery_type_id: delivery.id)
    end

    it 'sets order delivery' do
      expect(order.delivery_type).to eq delivery
    end

    it 'updates order total_price by adding delivery price' do
      new_total_price = total_price + delivery.price
      expect(order.total_price).to eq new_total_price
    end

    it 'transfers order to payment state' do
      expect(order).to be_payment
    end
  end
end

RSpec.describe CheckoutPresenter do
  subject(:presenter) { described_class.new(view: fake_view, order: order) }

  let(:order) { build(:order) }

  describe '#current_delivery?' do
    let(:delivery) { build(:delivery_type) }

    it 'returns true if delivery type the same as order delivery type' do
      order.delivery_type = delivery
      expect(presenter).to be_current_delivery(delivery, 0)
    end

    it 'returns true if order does not have delivery type and passed delivery tipe is first' do
      expect(presenter).to be_current_delivery(delivery, 0)
    end

    it 'returns false if order does not have delivery type and passed delivery tipe is not first' do
      expect(presenter).not_to be_current_delivery(delivery, 1)
    end
  end
end

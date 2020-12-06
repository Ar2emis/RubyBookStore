RSpec.describe FilteredOrdersQuery do
  describe '.call' do
    let(:user) { create(:user) }
    let(:orders) do
      [
        create(:order, state: :in_queue, user: user),
        create(:order, state: :in_delivery, user: user),
        create(:order, state: :delivered, user: user),
        create(:order, state: :canceled, user: user)
      ]
    end

    it 'returns orders by state' do
      orders.each do |order|
        expect(described_class.call(order.state, user)).to eq [order]
      end
    end

    it 'does not return not finished orders' do
      expect(described_class.call(:addresses, user)).to be_empty
    end
  end
end

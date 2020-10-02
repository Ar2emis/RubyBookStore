RSpec.describe ChangeOrderStateService do
  describe '.call' do
    let(:order) { build(:order, state: :confirm) }
    let(:state) { :addresses }

    before do
      described_class.call(order: order, state: state)
    end

    it 'transfers order to passed state' do
      expect(order).to be_addresses
    end
  end
end

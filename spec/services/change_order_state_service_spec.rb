RSpec.describe ChangeOrderStateService do
  describe '.call' do
    let(:order) { build(:order, state: :confirm) }

    %i[addresses delivery payment].each do |state|
      it 'transfers order to passed state' do
        described_class.call(order: order, state: state)
        expect(order).to have_state(state)
      end
    end
  end
end

RSpec.describe OrdersPresenter do
  subject(:presenter) { described_class.new(view: fake_view, orders: [build_list(:order, orders_amount)], state: nil) }

  let(:orders_amount) { 3 }

  describe '#filter_states' do
    it 'returns FILTER_STATES hash' do
      expect(presenter.filter_states).to eq described_class::FILTER_STATES
    end
  end

  describe '#divider' do
    context 'when index is not last element' do
      let(:index) { presenter.orders.count - 2 }

      it 'returns divider css' do
        expect(presenter.divider(index)).to eq described_class::DIVIDER_CLASS
      end
    end

    context 'when index is last element' do
      let(:index) { presenter.orders.count - 1 }

      it 'returns nil' do
        expect(presenter.divider(index)).to be_nil
      end
    end
  end

  describe '#current_filter' do
    described_class::FILTER_STATES.merge(invalid_state: described_class::DATE).each do |state, text|
      it "returns #{text} for #{state}" do
        presenter = described_class.new(view: fake_view, orders: [], state: state)
        expect(presenter.current_filter).to eq text
      end
    end
  end

  describe '#state_color' do
    described_class::STATE_COLORS.each do |state, color|
      it "returns #{color} css for #{state}" do
        presenter = described_class.new(view: fake_view, orders: [], state: nil)
        order = build(:order, state: state)
        expect(presenter.state_color(order)).to eq color
      end
    end
  end
end

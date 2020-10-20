RSpec.describe CheckoutPresenter do
  subject(:presenter) { described_class.new(view: fake_view, order: order) }

  let(:order) { build(:order, state: Order.states[:delivery]) }

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

  describe '#states' do
    it 'returns list of states' do
      expect(presenter.states).to be_a Array
    end
  end

  describe '#state_done?' do
    let(:completed_step) { :addresses }
    let(:uncompleted_step) { :confirm }

    it 'returns true if state already done' do
      expect(presenter).to be_state_done(completed_step)
    end

    it 'returns false if state does not completed' do
      expect(presenter).not_to be_state_done(uncompleted_step)
    end
  end

  describe '#last_state?' do
    let(:not_last_state_index) { presenter.states.count - 2 }
    let(:last_state_index) { presenter.states.count - 1 }

    it 'returns true if state is last' do
      expect(presenter).to be_last_state(last_state_index)
    end

    it 'returns false if state is not last' do
      expect(presenter).not_to be_last_state(not_last_state_index)
    end
  end
end

RSpec.describe BuildOrderService do
  describe '.call' do
    let(:session) { {} }

    it 'returns instance of the service' do
      expect(described_class.call(session: session)).to be_a described_class
    end

    context 'when session does not contain current order id and user is not authenticated' do
      subject(:service) { described_class.call(session: session) }

      it 'creates order' do
        expect(service.current_order).to be_a Order
      end

      it 'writes order id to session' do
        described_class.call(session: session)
        expect(session[:current_order]).not_to be_nil
      end
    end

    context 'when session contains current order id and user is not authenticated' do
      subject(:service) { described_class.call(session: session) }

      let(:session) { { current_order: create(:order).id } }

      it 'loads order from database' do
        expect(service.current_order).to be_persisted
      end
    end

    context 'when session does not contain current order id and user is authenticated' do
      subject(:service) { described_class.call(session: session, user: user) }

      let(:session) { {} }
      let(:user) { build(:user) }

      it 'returns user cart' do
        expect(service.current_order).to eq user.current_order
      end
    end

    context 'when session contains current order id and user is authenticated' do
      subject(:service) { described_class.call(session: session, user: user) }

      let(:order) { create(:order) }
      let(:session) { { current_order: order.id } }
      let(:user) { create(:user, current_order: nil) }

      it 'loads order from database' do
        expect(service.current_order).to be_persisted
      end

      it 'assigns order to user' do
        described_class.call(session: session, user: user)
        expect(user.current_order).to eq order
      end

      it 'removes current order id from session' do
        described_class.call(session: session, user: user)
        expect(session[:current_order]).to be_nil
      end
    end
  end
end

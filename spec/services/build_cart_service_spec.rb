RSpec.describe BuildCartService do
  describe '.call' do
    let(:session) { {} }

    it 'returns instance of the service' do
      expect(described_class.call(session: session)).to be_a described_class
    end

    context 'when session does not contain cart id and user is not authenticated' do
      subject(:service) { described_class.call(session: session) }

      it 'creates cart' do
        expect(service.shopping_cart).to be_a Cart
      end

      it 'writes cart id to session' do
        described_class.call(session: session)
        expect(session[:shopping_cart]).not_to be_nil
      end
    end

    context 'when session contains cart id and user is not authenticated' do
      subject(:service) { described_class.call(session: session) }

      let(:session) { { shopping_cart: create(:cart).id } }

      it 'loads cart from database' do
        expect(service.shopping_cart).to be_persisted
      end
    end

    context 'when session does not contain cart id and user is authenticated' do
      subject(:service) { described_class.call(session: session, user: user) }

      let(:session) { {} }
      let(:user) { build(:user) }

      it 'returns user cart' do
        expect(service.shopping_cart).to eq user.cart
      end
    end

    context 'when session contains cart id and user is authenticated' do
      subject(:service) { described_class.call(session: session, user: user) }

      let(:cart) { create(:cart) }
      let(:session) { { shopping_cart: cart.id } }
      let(:user) { create(:user, cart: nil) }

      it 'loads cart from database' do
        expect(service.shopping_cart).to be_persisted
      end

      it 'assigns cart to user' do
        described_class.call(session: session, user: user)
        expect(user.cart).to eq cart
      end

      it 'removes cart id from session' do
        described_class.call(session: session, user: user)
        expect(session[:shopping_cart]).to be_nil
      end
    end
  end
end

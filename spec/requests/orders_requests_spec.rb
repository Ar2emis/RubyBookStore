RSpec.describe 'Orders', type: :request do
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  describe 'GET /index' do
    before do
      get orders_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /show' do
    let(:order) { create(:order, user: user, state: :in_queue, delivery_type: create(:delivery_type)) }

    before do
      create(:address, type: BillingAddress.to_s, addressable: order)
      create(:address, type: ShippingAddress.to_s, addressable: order)
      create(:card, order: order)
      get order_path(order)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders show template' do
      expect(response).to render_template(:show)
    end
  end
end

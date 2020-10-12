require 'rails_helper'

RSpec.describe 'Checkouts', type: :request do
  let(:user) { create(:user) }

  describe 'GET /checkout' do
    before do
      sign_in(user)
      user.cart.cart_items << create(:cart_item, cart: user.cart)
      get checkout_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders show template' do
      expect(response).to render_template(:show)
    end
  end

  describe 'PUT /checkout' do
    let(:order) { create(:order, user: user) }
    let(:cart) { create(:cart, user: user) }
    let(:order_params) { { billing_address: attributes_for(:address, address_type: :billing), only_billing: true } }

    before do
      cart.cart_items.create(attributes_for(:cart_item))
      sign_in(user)
      put checkout_path, params: { order: order_params }
    end

    it 'returns http redirect' do
      expect(response).to have_http_status(:redirect)
    end

    it 'renders show template' do
      expect(response).to redirect_to(checkout_path)
    end
  end
end

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

    before do
      transfer_service = instance_double(TransferCartToOrderService)
      allow(transfer_service).to receive(:call)
      allow(transfer_service).to receive(:order).and_return(order)
      allow(TransferCartToOrderService).to receive(:new).and_return(transfer_service)
      address_service = instance_double(AddOrderAddressesService)
      allow(address_service).to receive(:call)
      allow(AddOrderAddressesService).to receive(:new).and_return(address_service)
      sign_in(user)
      put checkout_path, params: { order: { a: 1 } }
    end

    it 'returns http redirect' do
      expect(response).to have_http_status(:redirect)
    end

    it 'renders show template' do
      expect(response).to redirect_to(checkout_path)
    end
  end
end

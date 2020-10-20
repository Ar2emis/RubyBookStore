RSpec.describe 'Checkouts', type: :request do
  let(:user) { create(:user) }

  describe 'GET /checkout' do
    context 'when user ready to make order' do
      before do
        sign_in(user)
        user.current_order.order_items.create(attributes_for(:order_item))
        get checkout_path
      end

      it 'returns http success' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders show template' do
        expect(response).to render_template(:show)
      end
    end

    context 'when user is not signed in' do
      let(:order_item_params) { { order: { order_item: { book_id: create(:book).id } } } }

      before do
        put cart_path, params: order_item_params
        get checkout_path
      end

      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to quick registration page' do
        expect(response).to redirect_to(quick_registration_path)
      end
    end
  end

  describe 'PUT /checkout' do
    let(:order_params) { { billing_address: attributes_for(:address, address_type: :billing), only_billing: true } }

    before do
      user.current_order.order_items.create(attributes_for(:order_item))
      sign_in(user)
      put checkout_path, params: { order: order_params }
    end

    it 'returns http redirect' do
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects to show page' do
      expect(response).to redirect_to(checkout_path)
    end
  end
end

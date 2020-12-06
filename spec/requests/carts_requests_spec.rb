require 'rails_helper'

RSpec.describe 'CartItemsRequests', type: :request do
  describe 'GET /cart' do
    before do
      get cart_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders show template' do
      expect(response).to render_template(:show)
    end
  end

  describe 'POST /cart' do
    let(:book) { create(:book) }

    before do
      put cart_path, params: { order: { order_item: { book_id: book.id } } }
    end

    it 'returns http redirect' do
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects to previous page' do
      expect(response).to redirect_to(cart_path)
    end
  end

  describe 'PUT /cart' do
    let(:params) { { order: { order_item: { delete_id: 1 } } } }

    before do
      put cart_path, params: params, xhr: true
    end

    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders update template' do
      expect(response).to render_template(:update)
    end
  end

  describe 'POST /coupon' do
    let(:coupon) { create(:coupon) }
    let(:params) { { order: { coupon: { code: coupon.code } } } }

    before do
      put cart_path, params: params
    end

    it 'returns http redirect' do
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects to previous page' do
      expect(response).to redirect_to(cart_path)
    end
  end
end

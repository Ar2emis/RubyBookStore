require 'rails_helper'

RSpec.describe 'CartItemsRequests', type: :request do
  describe 'GET /cart' do
    before do
      get cart_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'POST /cart_items' do
    let(:book) { create(:book) }

    before do
      post cart_items_path, params: { cart_item: { book_id: book.id } }
    end

    it 'returns http redirect' do
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects to previous page' do
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'DELETE /cart_items' do
    let(:cart_item_id) { 1 }

    before do
      delete cart_item_path(id: cart_item_id), xhr: true
    end

    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'redirects to previous page' do
      expect(response).to render_template(:destroy)
    end
  end

  describe 'POST /coupon' do
    let(:coupon) { create(:coupon) }

    before do
      post coupon_path, params: { coupon: { code: coupon.code } }
    end

    it 'returns http redirect' do
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects to previous page' do
      expect(response).to redirect_to(cart_path)
    end
  end
end

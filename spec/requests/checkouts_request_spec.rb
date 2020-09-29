require 'rails_helper'

RSpec.describe 'Checkouts', type: :request do
  describe 'GET /checkout' do
    context 'when user signed in' do
      before do
        sign_in(create(:user))
        get checkout_path
      end

      it 'returns http redirect status' do
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to home page' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is not signed in' do
      before do
        get checkout_path
      end

      it 'returns http success status' do
        expect(response).to have_http_status(:ok)
      end

      it 'redirects to home page' do
        expect(response).to render_template(:show)
      end
    end
  end
end

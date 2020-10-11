RSpec.describe 'RegistrationsRequests', type: :request do
  describe 'GET /users/edit' do
    before do
      user = create(:user)
      sign_in(user)
      get edit_user_registration_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders a home index template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST /quick_registration' do
    context 'when params are valid' do
      before do
        post quick_registration_path, params: { user: { email: Faker::Internet.email } }
      end

      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to checkout page' do
        expect(response).to redirect_to(checkout_path)
      end
    end

    context 'when params are invalid' do
      before do
        post quick_registration_path
      end

      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to checkout page' do
        expect(response).to redirect_to(checkout_path)
      end
    end
  end
end

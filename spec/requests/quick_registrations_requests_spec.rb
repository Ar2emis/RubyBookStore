RSpec.describe 'QuickRegistrationsRequest', type: :request do
  describe 'GET /quick_registration' do
    context 'when user signed in' do
      before do
        sign_in(create(:user))
        get quick_registration_path
      end

      it 'returns http redirect status' do
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to root page' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is not signed in' do
      before do
        get quick_registration_path
      end

      it 'returns http ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders show template' do
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'POST /quick_registration' do
    let(:email) { attributes_for(:user)[:email] }

    context 'when params are valid' do
      before do
        post quick_registration_path, params: { user: { email: email } }
      end

      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to the latest location' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when params are invalid' do
      before do
        post quick_registration_path
      end

      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to quick registration page' do
        expect(response).to redirect_to(quick_registration_path)
      end
    end
  end
end

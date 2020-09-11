RSpec.describe 'OmniauthCallbacks', type: :request do
  describe 'POST /users/auth/facebook' do
    let(:callback) { Faker::Omniauth.facebook }

    before do
      allow(User).to receive(:from_omniauth).and_return(create(:user))
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(callback)
    end

    it 'has redirect status' do
      post user_facebook_omniauth_callback_path(callback)
      expect(response).to have_http_status(:redirect)
    end

    context 'when user exists' do
      it 'redirects to home page' do
        post user_facebook_omniauth_callback_path(callback)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user new' do
      before do
        allow(User).to receive(:from_omniauth).and_return(build(:user))
        post user_facebook_omniauth_callback_path(callback)
      end

      it 'registers user' do
        expect(response).to redirect_to(new_user_registration_path)
      end
    end

    context 'when callback fails' do
      before do
        allow(OmniAuth.logger).to receive(:info)
        OmniAuth.config.mock_auth[:facebook] = :invalid_credencials
        post user_facebook_omniauth_callback_path(callback)
      end

      it 'logs fail message' do
        expect(OmniAuth.logger).to have_received(:info)
          .with(/Processing by OmniauthCallbacksController#failure/)
      end

      it 'redirects to home page' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end

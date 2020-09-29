RSpec.describe 'OmniauthCallbacks', type: :request do
  describe 'POST /users/auth/facebook' do
    let(:callback) { Faker::Omniauth.facebook }

    before do
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(callback)
    end

    context 'when callback is successful' do
      before do
        post user_facebook_omniauth_callback_path(callback)
      end

      it 'has redirect status' do
        expect(response).to have_http_status(:redirect)
      end

      it 'authorizes user' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when callback fails' do
      before do
        OmniAuth.config.logger = Rails.logger
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

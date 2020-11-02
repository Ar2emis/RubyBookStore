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
end

RSpec.describe 'StaticPages', type: :request do
  describe 'GET /home' do
    before do
      create_list(:book, StaticPagesController::LATEST_BOOKS_AMOUNT)
      get root_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders a home index template' do
      expect(response).to render_template(:home)
    end
  end
end

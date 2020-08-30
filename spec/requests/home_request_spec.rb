require 'rails_helper'

RSpec.describe 'Home', type: :request do
  describe 'GET /index' do
    before do
      create_list(:book, HomeController::LATEST_BOOKS_AMOUNT)
      get root_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders a home index template' do
      expect(response).to render_template(:index)
    end
  end
end

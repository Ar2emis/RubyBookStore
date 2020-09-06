require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'GET /books' do
    let(:books_amount) { 3 }

    before do
      create_list(:book, books_amount)
      get books_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders a books index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /books/:id' do
    let(:book) { create(:book) }

    before do
      get book_path(book)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders a books index template' do
      expect(response).to render_template(:show)
    end
  end
end

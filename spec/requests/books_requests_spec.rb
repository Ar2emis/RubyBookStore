RSpec.describe 'BooksRequest', type: :request do
  describe 'GET /books' do
    before do
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
    context 'with valid book id' do
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

    context 'with invalid book id' do
      let(:invalid_book_id) { -1 }

      before do
        get book_path(id: invalid_book_id)
      end

      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
      end

      it 'renders a books index template' do
        expect(response).to redirect_to(books_path)
      end
    end
  end
end

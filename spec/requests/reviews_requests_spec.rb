RSpec.describe 'ReviewsRequests', type: :request do
  describe 'POST /reviews_request' do
    let(:review_attributes) { attributes_for(:review) }

    before do
      sign_in review_attributes[:user]
    end

    context 'with valid review data' do
      let(:review_post_data) do
        review_attributes.except(:book, :user, :date, :status).merge(book_id: review_attributes[:book].id)
      end

      before do
        post reviews_path, params: { review: review_post_data }, xhr: true
      end

      it 'returns https ok status' do
        expect(response).to have_http_status(:ok)
      end

      it "doesn't render create template" do
        expect(response).not_to render_template(:create)
      end
    end

    context 'with invalid review data' do
      before do
        post reviews_path, params: { review: { book_id: 'a' } }, xhr: true
      end

      it 'returns https ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'render create template' do
        expect(response).to render_template(:create)
      end
    end
  end
end

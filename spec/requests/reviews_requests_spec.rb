require 'rails_helper'

RSpec.describe 'ReviewsRequests', type: :request do
  describe 'POST /reviews_request' do
    let(:review_attributes) { attributes_for(:review) }
    let(:review_post_data) do
      review_attributes.except(:book, :status).merge(book_id: review_attributes[:book].id)
    end

    before do
      sign_in review_attributes[:user]
      post reviews_path, params: { review: review_post_data }
    end

    it 'returns https redirect status' do
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects back' do
      expect(response).not_to redirect_to(root_path)
    end
  end
end

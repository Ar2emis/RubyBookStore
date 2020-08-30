require 'rails_helper'

RSpec.describe 'CartTransactions', type: :request do
  describe 'POST /create' do
    let(:quantity) { Faker::Number.within(range: 1..10) }
    let(:book) { create(:book) }

    before do
      get root_path
    end

    context 'with valid params' do
      before do
        post cart_items_path, params: { cart_item: { book_id: book.id, quantity: quantity } }
      end

      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects back' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid params' do
      let(:invalid_book_id) { 0 }
      let(:invalid_quantity) { 0 }

      it 'works correctly when book id is invalid' do
        post cart_items_path, params: { cart_item: { book_id: invalid_book_id, quantity: quantity } }
        expect(response).not_to have_http_status(:internal_server_error)
      end

      it 'works correctly when quantity is invalid' do
        post cart_items_path, params: { cart_item: { book_id: book.id, quantity: invalid_quantity } }
        expect(response).not_to have_http_status(:internal_server_error)
      end
    end
  end
end

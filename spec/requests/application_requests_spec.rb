RSpec.describe 'ApplicationRequests', type: :request do
  describe '#transfer_cart_to_user' do
    let(:user) { create(:user, cart: nil) }
    let(:order_item_params) { { order: { order_item: { book_id: create(:book).id } } } }

    before do
      put cart_path, params: order_item_params
      sign_in(user)
      get root_path
    end

    it 'assigns cart to user' do
      expect(user.cart).not_to be_nil
    end
  end
end

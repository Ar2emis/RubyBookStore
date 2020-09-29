require 'rails_helper'

RSpec.describe 'Addresses', type: :request do
  describe 'PUT /addresses' do
    let(:address_attributes) { attributes_for(:address) }
    let(:user) { create(:user) }

    before do
      sign_in(user)
      put address_path, params: { address: address_attributes.except(:user) }, xhr: true
    end

    it 'returns http success status' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders update template' do
      expect(response).to render_template(:update)
    end
  end
end

RSpec.describe 'Checkout Delivery', type: :feature do
  let(:user) { create(:user) }
  let(:order) { create(:order, user: user, state: :delivery) }
  let!(:delivery_types) { create_list(:delivery_type, 3) }

  before do
    user.cart = order
    user.cart.order_items.create(attributes_for(:order_item))
    sign_in(user)
  end

  describe 'delivery types' do
    before do
      visit checkout_path
    end

    it 'displays delivery types' do
      delivery_types.map(&:name).each do |name|
        expect(page).to have_content(name)
      end
    end
  end

  describe 'delivery form' do
    before do
      visit checkout_path
      within 'div.hidden-xs.mb-res-50' do
        click_button(I18n.t('checkouts.save_and_continue'))
      end
    end

    it 'renders next state' do
      expect(page).to have_selector('h3', text: I18n.t('checkouts.payment.credit_card'))
    end
  end
end

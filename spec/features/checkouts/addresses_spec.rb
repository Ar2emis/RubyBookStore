RSpec.describe 'Checkout Addresses', type: :feature do
  let(:user) { create(:user) }
  let(:order) { create(:order, user: user) }

  before do
    user.cart.cart_items.create!(attributes_for(:cart_item))
    page.set_rack_session(order: order.id)
    sign_in(user)
  end

  describe 'addresses form', js: true do
    let(:address_data) { attributes_for(:address) }

    context 'when valid input' do
      before do
        visit checkout_path
        within 'div.col-md-5.mb-40' do
          fill_in(I18n.t('simple_form.placeholders.defaults.first_name'), with: address_data[:first_name])
          fill_in(I18n.t('simple_form.placeholders.defaults.last_name'), with: address_data[:last_name])
          fill_in(I18n.t('simple_form.placeholders.defaults.address'), with: address_data[:address])
          fill_in(I18n.t('simple_form.placeholders.defaults.city'), with: address_data[:city])
          fill_in(I18n.t('simple_form.placeholders.defaults.zip'), with: address_data[:zip])
          page.select(address_data[:country], from: 'order_billing_address_country')
          fill_in(I18n.t('simple_form.placeholders.defaults.phone'), with: address_data[:phone])
        end
        page.find('span.checkbox-icon').click
        click_button(I18n.t('checkouts.save_and_continue'))
      end

      it 'renders next state' do
        expect(page).to have_selector('h3', text: I18n.t('checkouts.delivery.delivery'))
      end
    end

    context 'when invalid input' do
      before do
        visit checkout_path
        click_button(I18n.t('checkouts.save_and_continue'))
      end

      it 'displays errors' do
        expect(page).to have_content(I18n.t('errors.messages.blank'))
      end
    end
  end
end

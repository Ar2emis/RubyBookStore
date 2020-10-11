RSpec.describe 'Checkout Payment', type: :feature do
  let(:user) { create(:user) }
  let(:order) { create(:order, user: user, state: :payment) }

  before do
    create(:address, type: BillingAddress.to_s, addressable: order)
    create(:address, type: ShippingAddress.to_s, addressable: order)
    order.delivery_type = create(:delivery_type)
    page.set_rack_session(order: order.id)
    sign_in(user)
  end

  describe 'card form', js: true do
    let(:card_data) { attributes_for(:card) }

    context 'when valid input' do
      before do
        visit checkout_path
        fill_in(I18n.t('simple_form.placeholders.defaults.number'), with: card_data[:number])
        fill_in(I18n.t('simple_form.placeholders.defaults.name'), with: card_data[:name])
        fill_in(I18n.t('simple_form.placeholders.defaults.expiration_date'), with: card_data[:expiration_date])
        fill_in(I18n.t('simple_form.placeholders.defaults.cvv'), with: card_data[:cvv])
        click_button(I18n.t('checkouts.save_and_continue'))
      end

      it 'renders next state' do
        expect(page).to have_selector('a', text: I18n.t('checkouts.confirm.place_order'))
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

RSpec.describe 'Checkout Confirm', type: :feature do
  let(:user) { create(:user) }
  let(:order) { create(:order, user: user, state: :confirm) }
  let!(:billing_address) { create(:address, address_type: :billing, addressable: order) }
  let!(:shipping_address) { create(:address, address_type: :shipping, addressable: order) }
  let(:delivery_type) { create(:delivery_type) }

  before do
    user.cart = order
    user.cart.order_items.create(attributes_for(:order_item))
    order.card = create(:card, order: order)
    order.delivery_type = delivery_type
    sign_in(user)
    visit checkout_path
  end

  describe 'billing address' do
    it { expect(page).to have_content(billing_address.first_name) }
    it { expect(page).to have_content(billing_address.last_name) }
    it { expect(page).to have_content(billing_address.city) }
    it { expect(page).to have_content(billing_address.address) }
    it { expect(page).to have_content(billing_address.country) }
    it { expect(page).to have_content(billing_address.phone) }
  end

  describe 'shipping address' do
    it { expect(page).to have_content(shipping_address.first_name) }
    it { expect(page).to have_content(shipping_address.last_name) }
    it { expect(page).to have_content(shipping_address.city) }
    it { expect(page).to have_content(shipping_address.address) }
    it { expect(page).to have_content(shipping_address.country) }
    it { expect(page).to have_content(shipping_address.phone) }
  end

  describe 'delivery' do
    it { expect(page).to have_content(delivery_type.name) }
  end

  describe 'card' do
    it { expect(page).to have_content(order.card.number[-4..]) }
    it { expect(page).to have_content(order.card.expiration_date) }
  end

  describe 'order items' do
    it 'displays ordered books' do
      order.order_items.map { |item| item.book.title }.each do |title|
        expect(page).to have_content(title)
      end
    end
  end

  describe 'order confirmation' do
    it 'redirects to complete page' do
      click_link(I18n.t('checkouts.confirm.place_order'))
      expect(page).to have_content(I18n.t('checkouts.complete.thanks'))
    end
  end
end

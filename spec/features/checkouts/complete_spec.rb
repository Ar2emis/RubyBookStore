RSpec.describe 'Checkout Complete', type: :feature do
  let(:user) { create(:user) }
  let(:order) { create(:order, user: user, state: :complete) }
  let!(:billing_address) { create(:address, address_type: :billing, addressable: order) }
  let(:delivery_type) { create(:delivery_type) }

  before do
    user.current_order = order
    order.order_items.create(attributes_for(:order_item))
    order.delivery_type = delivery_type
    sign_in(user)
    visit checkout_path
  end

  describe 'order' do
    it { expect(page).to have_content(order.number) }
  end

  describe 'billing address' do
    it { expect(page).to have_content(billing_address.first_name) }
    it { expect(page).to have_content(billing_address.last_name) }
    it { expect(page).to have_content(billing_address.city) }
    it { expect(page).to have_content(billing_address.address) }
    it { expect(page).to have_content(billing_address.country) }
    it { expect(page).to have_content(billing_address.phone) }
  end

  describe 'order items' do
    it 'displays ordered books' do
      order.order_items.map { |item| item.book.title }.each do |title|
        expect(page).to have_content(title)
      end
    end
  end
end

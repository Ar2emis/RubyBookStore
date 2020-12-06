RSpec.describe 'Index', type: :feature do
  let(:user) { create(:user) }
  let(:in_queue_orders) { create_list(:order, 3, user: user, state: :in_queue) }
  let(:delivered_orders) { create_list(:order, 3, user: user, state: :delivered) }
  let(:orders_amount) { 3 }

  before do
    user.orders = in_queue_orders + delivered_orders
    sign_in(user)
    visit orders_path
  end

  describe 'orders' do
    it 'displays all orders by default' do
      (in_queue_orders + delivered_orders).map(&:number).each do |number|
        expect(page).to have_content(number)
      end
    end
  end

  describe 'filtering' do
    before do
      within 'div.dropdowns.dropdown' do
        click_link(I18n.t('orders.delivered'))
      end
    end

    it 'displays delivered orders' do
      delivered_orders.map(&:number).each do |number|
        expect(page).to have_content(number)
      end
    end

    it 'does not display other orders' do
      in_queue_orders.map(&:number).each do |number|
        expect(page).not_to have_content(number)
      end
    end
  end
end

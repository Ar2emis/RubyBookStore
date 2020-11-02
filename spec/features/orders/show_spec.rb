RSpec.describe 'Show', type: :feature do
  describe 'order data' do
    let(:user) { create(:user) }
    let(:order) { create(:order, user: user, delivery_type: create(:delivery_type), state: :delivered) }
    let(:decorated_order) { order.decorate }

    before do
      order.order_items.create(attributes_for(:order_item))
      create(:address, address_type: :billing, addressable: order)
      create(:address, address_type: :shipping, addressable: order)
      create(:card, order: order)
      user.orders << order
      sign_in(user)
      visit order_path(order)
    end

    it 'displays billing address data' do
      address = decorated_order.billing_address
      [address.full_name, address.city_with_zip, address.country, address.phone, address.address].each do |property|
        expect(page).to have_content(property)
      end
    end

    it 'displays shipping address data' do
      address = decorated_order.shipping_address
      [address.full_name, address.city_with_zip, address.country, address.phone, address.address].each do |property|
        expect(page).to have_content(property)
      end
    end

    it 'displays delivery data' do
      delivery = decorated_order.delivery_type
      [delivery.name, delivery.price].each do |property|
        expect(page).to have_content(property)
      end
    end

    it 'displays card data' do
      card = decorated_order.card
      [card.last_four_digits, card.expiration_date].each do |property|
        expect(page).to have_content(property)
      end
    end

    it 'displays order item data' do
      item = decorated_order.order_items.first
      [item.book.title, item.book.description, item.book.price, item.quantity, item.subtotal].each do |property|
        expect(page).to have_content(property)
      end
    end

    it 'displays order data' do
      order = decorated_order
      [order.subtotal, order.total_price].each do |property|
        expect(page).to have_content(property)
      end
    end
  end
end

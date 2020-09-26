RSpec.describe 'cart_items#index', type: :feature do
  let(:user) { create(:user, coupons: [create(:coupon)]) }
  let(:cart_items_amount) { 3 }
  let(:cart_items) { create_list(:cart_item, cart_items_amount, cart: user.cart) }

  before do
    user.cart.cart_items = cart_items
    sign_in(user)
    visit cart_path
  end

  describe 'cart item deletion', js: true do
    before do
      within 'table.table.table-hover' do
        page.all('a.close.general-cart-close').first.click
      end
      sleep(0.5)
    end

    it 'deletes cart item from cart' do
      expect(page.all('a.close.general-cart-close').count).to eq cart_items_amount - 1
    end
  end

  describe 'book amount increasing', js: true do
    let(:amount) { 2 }

    before do
      within 'table.table.table-hover' do
        page.all('i.fa.fa-plus').first.click
      end
      sleep(0.5)
    end

    it 'increases book amount by 1' do
      expect(page.all('input.form-control.quantity-input').first.value.to_i).to eq amount
    end
  end

  describe 'book amount decreasing', js: true do
    let(:amount) { 2 }

    before do
      within 'table.table.table-hover' do
        2.times { page.all('i.fa.fa-plus').first.click }
        page.all('i.fa.fa-minus').first.click
      end
      sleep(0.5)
    end

    it 'decreases book amount by 1' do
      expect(page.all('input.form-control.quantity-input').first.value.to_i).to eq amount
    end
  end

  describe 'coupon feature' do
    context 'when coupon invalid' do
      let(:invalid_coupon_code) { 'invalid' }

      it 'displays invalid coupon message' do
        fill_in(I18n.t('cart.enter_coupon_code'), with: invalid_coupon_code)
        click_button(I18n.t('cart.apply_coupon'))
        expect(page).to have_content(I18n.t('cart.invalid_coupon'))
      end
    end

    context 'when coupon valid' do
      let(:valid_coupon) { create(:coupon) }

      it 'adds coupon sale to the cart' do
        fill_in(I18n.t('cart.enter_coupon_code'), with: valid_coupon.code)
        click_button(I18n.t('cart.apply_coupon'))
        [I18n.t('cart.invalid_coupon'), I18n.t('cart.coupon_used')].each do |message|
          expect(page).not_to have_content(message)
        end
      end
    end

    context 'when coupon was already used' do
      it 'adds coupon sale to the cart' do
        fill_in(I18n.t('cart.enter_coupon_code'), with: user.coupons.first.code)
        click_button(I18n.t('cart.apply_coupon'))
        expect(page).to have_content(I18n.t('cart.coupon_used'))
      end
    end
  end
end

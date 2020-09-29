class CartItemsController < ApplicationController
  before_action :prepare_cart

  def create
    cart_item = @shopping_cart.cart_items.where(book_id: cart_item_params[:book_id]).first
    cart_item ? update_cart_item(cart_item) : @shopping_cart.cart_items.create(cart_item_params)
    redirect_back(fallback_location: root_path, notice: I18n.t('flash.book_successfuly_added')) if request.format.html?
  end

  def destroy
    @shopping_cart.cart_items.find_by(id: params[:id])&.destroy
    @shopping_cart.reload
  end

  def coupon
    coupon = Coupon.find_by(code: params[:code])
    service = AddCouponService.call(coupon: coupon, cart: @shopping_cart)
    flash[:error] = service.errors.join(', ') unless service.success?
    redirect_to(cart_path)
  end

  private

  def update_cart_item(cart_item)
    cart_item.update(count: cart_item.count + cart_item_params[:count].to_i)
    @shopping_cart.reload
  end

  def prepare_cart
    ActiveRecord::Associations::Preloader.new.preload(@shopping_cart, [:coupon, { cart_items: :book }])
    @decorated_cart = @shopping_cart.decorate
  end

  def cart_item_params
    params.require(:cart_item).permit(:book_id, :count)
  end
end

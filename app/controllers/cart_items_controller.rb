class CartItemsController < ApplicationController
  before_action :prepare_cart

  def create
    cart_item = @shopping_cart.cart_items.where(book_id: cart_item_params[:book_id]).first
    return update_cart(cart_item) if cart_item

    @shopping_cart.cart_items.create(cart_item_params)
    redirect_back(fallback_location: root_path, notice: I18n.t('flash.book_successfuly_added'))
  end

  def destroy
    @shopping_cart.cart_items.find_by(id: params[:id])&.destroy
    @shopping_cart.cart_items.reload
  end

  def coupon
    coupon = Coupon.find_by(coupon_params)
    if coupon.nil?
      flash[:error] = I18n.t('cart.invalid_coupon')
    elsif coupon_used?(coupon)
      flash[:error] = I18n.t('cart.coupon_used')
    else
      @shopping_cart.update(coupon: coupon)
    end
    redirect_to(cart_path)
  end

  private

  def coupon_used?(coupon)
    user_signed_in? && current_user.coupons.exists?(coupon.id)
  end

  def update_cart(cart_item)
    cart_item.count += cart_item_params[:count].to_i
    cart_item.save
    @shopping_cart.reload
  end

  def prepare_cart
    @decorated_cart = @shopping_cart.decorate
  end

  def coupon_params
    params.require(:coupon).permit(:code)
  end

  def cart_item_params
    params.require(:cart_item).permit(:book_id, :count)
  end
end

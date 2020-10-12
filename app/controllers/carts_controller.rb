class CartsController < ApplicationController
  helper_method :decorated_cart

  def update
    if cart_params.key?(:cart_item) then update_cart_item(cart_params[:cart_item])
    elsif cart_params.key?(:coupon) then update_coupon(cart_params[:coupon])
    end

    respond_to do |format|
      format.js { @shopping_cart.reload }
      format.html { redirect_back(fallback_location: cart_path) }
    end
  end

  def destroy
    @shopping_cart.cart_items.find_by(id: params[:id])&.destroy
    @shopping_cart.cart_items.reload
  end

  private

  def update_coupon(coupon_params)
    service = AddCouponService.call(coupon_params: coupon_params, cart: @shopping_cart)
    service.success? ? flash[:success] = I18n.t('cart.coupon_added') : flash[:error] = service.errors_message
  end

  def update_cart_item(cart_item_params)
    UpdateCartItemService.call(cart_item_params: cart_item_params, cart: @shopping_cart)
    flash[:success] = I18n.t('flash.book_successfuly_added') if request.format.html?
  end

  def decorated_cart
    return @decorated_cart if @decorated_cart

    ActiveRecord::Associations::Preloader.new.preload(@shopping_cart, cart_items: :book)
    @decorated_cart = @shopping_cart.decorate
  end

  def cart_params
    params.require(:cart).permit(cart_item: %i[book_id amount], coupon: :code)
  end
end

class CartsController < ApplicationController
  helper_method :decorated_cart

  def update
    service = UpdateCartService.call(order: cart, params: cart_params)
    return if request.format.js?

    service.success? ? flash[:success] = service.success_message : flash[:error] = service.errors_message
    redirect_back(fallback_location: cart_path)
  end

  def cart
    return @cart if @cart

    @cart = current_user&.cart || Order.find_by(id: session[:cart]) || Order.create
    session[:cart] = @cart.id
    @cart
  end

  def decorated_cart
    @decorated_cart ||= cart.decorate if cart_items_count.positive?
  end

  def cart_params
    params.require(:order).permit(order_item: %i[delete_id book_id quantity], coupon: :code)
  end
end

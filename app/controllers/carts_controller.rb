class CartsController < ApplicationController
  helper_method :decorated_order

  def update
    service = UpdateCartService.call(order: current_order, params: cart_params)
    return if request.format.js?

    service.success? ? flash[:success] = service.success_message : flash[:error] = service.errors_message
    redirect_back(fallback_location: cart_path)
  end

  def current_order
    @current_order ||= current_user&.current_order || Order.where(id: session[:current_order]).first_or_create
    session[:current_order] = @current_order.id
    @current_order
  end

  def decorated_order
    @decorated_order ||= current_order.decorate if cart_items_count.positive?
  end

  def cart_params
    params.require(:order).permit(order_item: %i[delete_id book_id amount], coupon: :code)
  end
end

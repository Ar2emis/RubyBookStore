class CartsController < ApplicationController
  helper_method :decorated_order

  def update
    service = UpdateCartService.call(order: current_order, params: cart_params)
    return if request.format.js?

    service.success? ? flash[:success] = service.success_message : flash[:error] = service.errors_message
    redirect_back(fallback_location: cart_path)
  end

  def destroy
    current_order.order_items.find_by(id: params[:id])&.destroy
    return if current_order_items_count.positive?

    current_order.destroy
    session[:current_order] = nil
  end

  def current_order
    @current_order ||= BuildOrderService.call(user: current_user, session: session).current_order
  end

  def decorated_order
    @decorated_order ||= current_order.decorate if current_order_items_count.positive?
    @decorated_order
  end

  def cart_params
    params.require(:order).permit(order_item: %i[book_id amount], coupon: :code)
  end
end

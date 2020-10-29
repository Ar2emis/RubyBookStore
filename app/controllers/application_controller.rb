class ApplicationController < ActionController::Base
  before_action :transfer_cart_to_user
  helper_method :categories, :cart_items_count

  private

  def categories
    @categories ||= Category.all
  end

  def cart_items_count
    return @cart_items_count if @cart_items_count

    order = current_user&.cart || Order.find_by(id: session[:cart])
    @cart_items_count = OrderItem.where(order: order).count
  end

  def transfer_cart_to_user
    return unless user_signed_in? && session[:cart]

    current_user.cart = Order.find(session[:cart])
    session[:cart] = nil
  end
end

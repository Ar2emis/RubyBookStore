class ApplicationController < ActionController::Base
  helper_method :categories, :current_order_items_count

  private

  def categories
    @categories ||= Category.all
  end

  def current_order_items_count
    order = user_signed_in? ? current_user.current_order : session[:current_order]
    @current_order_items_count = order ? OrderItem.where(order: order).count : 0
  end
end

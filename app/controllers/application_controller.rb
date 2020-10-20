class ApplicationController < ActionController::Base
  before_action :transfer_cart_to_user
  helper_method :categories, :cart_items_count

  private

  def categories
    @categories ||= Category.all
  end

  def cart_items_count
    order = current_user&.current_order || Order.find_by(id: session[:current_order])
    @cart_items_count ||= OrderItem.where(order: order).count
  end

  def transfer_cart_to_user
    return unless user_signed_in? && session[:current_order]

    current_user.current_order = Order.find(session[:current_order])
    session[:current_order] = nil
  end
end

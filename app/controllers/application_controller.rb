class ApplicationController < ActionController::Base
  before_action :shopping_cart, :transfer_shopping_cart_to_user
  helper_method :categories, :countries

  private

  def categories
    Category.all
  end

  def countries
    ISO3166::Country.all.sort_by(&:name)
  end

  def shopping_cart
    if user_signed_in?
      @shopping_cart = current_user.cart
    elsif session[:shopping_cart]
      @shopping_cart = Cart.find(session[:shopping_cart])
    else
      @shopping_cart = Cart.create
      session[:shopping_cart] = @shopping_cart.id
    end
  end

  def transfer_shopping_cart_to_user
    return unless user_signed_in? && session[:shopping_cart]

    current_cart = Cart.find(session[:shopping_cart])
    current_user.cart = current_cart if current_cart.cart_items.any? || current_user.cart.nil?
    session[:shopping_cart] = nil
  end
end

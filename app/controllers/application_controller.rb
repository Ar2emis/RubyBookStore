class ApplicationController < ActionController::Base
  before_action :current_cart

  private

  def current_cart
    if session[:cart]
      @cart = Cart.find(session[:cart])
    else
      @cart = Cart.create
      session[:cart] = @cart.id
    end
  end
end

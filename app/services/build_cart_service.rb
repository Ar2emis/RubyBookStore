class BuildCartService < BaseService
  attr_reader :shopping_cart

  def initialize(**kwargs)
    super
    @session = kwargs[:session]
    @user = kwargs[:user]
  end

  def call
    transfer_cart_to_user if @user && @session[:shopping_cart]
    build_cart
  end

  private

  def build_cart
    if @user
      @shopping_cart = @user.cart
    elsif @session[:shopping_cart]
      @shopping_cart = Cart.find(@session[:shopping_cart])
    else
      @shopping_cart = Cart.create
      @session[:shopping_cart] = @shopping_cart.id
    end
  end

  def transfer_cart_to_user
    cart = Cart.find(@session[:shopping_cart])
    @user.cart = cart if cart.cart_items.any? || @user.cart.nil?
    @session[:shopping_cart] = nil
  end
end

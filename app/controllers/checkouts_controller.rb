class CheckoutsController < ApplicationController
  def show
    return redirect_to(cart_path, alert: 'Cart is empty!') if @shopping_cart.cart_items.empty?
    return store_location_for(:user, checkouts_path) unless user_signed_in?

    @state_view = 'addresses'
  end
end

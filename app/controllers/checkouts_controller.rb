class CheckoutsController < ApplicationController
  before_action :authenticate_user!, only: [:update]
  after_action :complete_order, only: [:show]
  helper_method :delivery_types, :checkout_presenter

  STATES = {
    addresses: AddOrderAddressesService,
    delivery: AddOrderDeliveryService,
    payment: AddOrderPaymentService,
    confirm: PlaceOrderService
  }.freeze

  def show
    return store_location_for(:user, checkout_path) unless user_signed_in?

    ChangeOrderStateService.call(order: current_order, state: params[:state]) if params[:state]
    @state_view = current_order.state
  end

  def update
    service = STATES[current_order.state.to_sym]
    service.call(**order_params)
    redirect_to(checkout_path)
  end

  private

  def complete_order
    return unless user_signed_in? && current_order.complete?

    current_order.in_queue_step!
    session[:order] = nil
    @shopping_cart.cart_items.destroy_all
  end

  def order_params
    params.require(:order).permit(
      :only_billing, :delivery_type_id,
      card: %i[number name expiration_date cvv],
      billing_address: address_params,
      shipping_address: address_params
    ).to_h.symbolize_keys.merge(order: current_order)
  end

  def address_params
    %i[first_name last_name address city zip country phone]
  end

  def current_order
    @current_order ||= Order.find_by(id: session[:order]) || TransferCartToOrderService.call(cart: @shopping_cart).order
    session[:order] ||= @current_order.id
    @current_order
  end

  def delivery_types
    DeliveryType.all
  end

  def checkout_presenter
    @checkout_presenter ||= CheckoutPresenter.new(view: view_context, order: current_order.decorate)
  end
end

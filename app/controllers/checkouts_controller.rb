class CheckoutsController < ApplicationController
  before_action :check_cart
  before_action :authenticate_user!, only: [:update]
  after_action :complete_order, only: [:show]

  STATES_ORDERS = {
    addresses: AddOrderAddressesService,
    delivery: AddOrderDeliveryService,
    payment: AddOrderPaymentService,
    confirm: PlaceOrderService
  }.freeze

  def show
    return store_location_for(:user, checkout_path) unless user_signed_in?

    ChangeOrderStateService.call(order: current_order, state: params[:state]) if params[:state]
    @state_view = current_order.state
    @order = current_order.decorate
    @presenter = CheckoutPresenter.new(view: view_context, order: @order)
  end

  def update
    service = STATES_ORDERS[current_order.state.to_sym]
    service.call(**order_params)
    redirect_to(checkout_path)
  end

  private

  def complete_order
    return unless user_signed_in? && current_order.complete?

    CompleteOrderService.call(cart: @shopping_cart, order: current_order, session: session)
  end

  def order_params
    params.require(:order).permit(
      :only_billing, :delivery_type_id,
      card: %i[number name expiration_date cvv], billing_address: address_params, shipping_address: address_params
    ).merge(order: current_order)
  end

  def address_params
    %i[first_name last_name address city zip country phone address_type]
  end

  def current_order
    @current_order ||= BuildCurrentOrderService.call(cart: @shopping_cart, session: session).order
  end

  def check_cart
    redirect_to(cart_path) if @shopping_cart.cart_items.empty?
  end
end

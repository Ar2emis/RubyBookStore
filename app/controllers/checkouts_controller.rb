class CheckoutsController < ApplicationController
  before_action :check_preparations
  after_action :complete_order, only: [:show]

  STATES_ORDERS = {
    addresses: AddOrderAddressesService,
    delivery: AddOrderDeliveryService,
    payment: AddOrderPaymentService,
    confirm: PlaceOrderService
  }.freeze

  def show
    ChangeOrderStateService.call(order: current_order, state: params[:state]) if params[:state]
    @order = current_order.decorate
    @presenter = CheckoutPresenter.new(view: view_context, order: @order)
  end

  def update
    service_class = STATES_ORDERS[current_order.state.to_sym]
    service = service_class.call(**order_params)
    flash[:error] = service.errors_message unless service.success?
    redirect_to(checkout_path)
  end

  private

  def order_params
    params.require(:order).permit(
      :only_billing, :delivery_type_id,
      card: %i[number name expiration_date cvv], billing_address: address_params, shipping_address: address_params
    ).to_h.symbolize_keys.merge(order: current_order)
  end

  def address_params
    %i[first_name last_name address city zip country phone address_type]
  end

  def current_order
    current_user.current_order
  end

  def complete_order
    current_order.in_queue_step! if current_order.complete?
  end

  def check_preparations
    return redirect_to(root_path) unless cart_items_count.positive?
    return if user_signed_in?

    store_location_for(:user, checkout_path)
    redirect_to(quick_registration_path)
  end
end

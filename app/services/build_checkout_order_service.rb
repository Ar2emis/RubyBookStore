class BuildCheckoutOrderService < BaseService
  attr_reader :order

  def initialize(**kwargs)
    super
    @user = kwargs[:user]
    @session = kwargs[:session]
  end

  def call
    return unless @user&.current_order || @session[:current_order]

    @order = current_order
    @order.billing_address ||= @user.billing_address.dup
    @order.shipping_address ||= @user.shipping_address.dup
  end

  private

  def current_order
    return @user.current_order if @user.current_order

    @user.current_order = Order.find(@session[:current_order])
    @session[:current_order] = nil
    @user.current_order
  end
end

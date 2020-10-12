class CompleteOrderService < BaseService
  def initialize(**kwargs)
    super
    @cart = kwargs[:cart]
    @session = kwargs[:session]
    @order = kwargs[:order]
  end

  def call
    @order.in_queue_step!
    @session[:order] = nil
    @cart.cart_items.destroy_all
  end
end

class BuildCurrentOrderService < BaseService
  attr_reader :order

  def initialize(**kwargs)
    super
    @cart = kwargs[:cart].decorate
    @session = kwargs[:session]
  end

  def call
    return @order = Order.find(@session[:order]) if @session[:order]

    transfer_order_from_cart
    @session[:order] = @order.id
  end

  private

  def transfer_order_from_cart
    @order = Order.create(user: @cart.user, total_price: @cart.total_price, coupon: @cart.coupon,
                          billing_address: @cart.user.billing_address.dup,
                          shipping_address: @cart.user.shipping_address.dup)
    @order.order_items.create(@cart.cart_items.map { |item| { book: item.book, amount: item.amount } })
  end
end

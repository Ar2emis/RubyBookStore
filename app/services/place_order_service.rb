class PlaceOrderService < BaseService
  ORDER_NUMBER_LENGTH = 8

  def initialize(**kwargs)
    super
    @order = kwargs[:order]
  end

  def call
    @order.update(number: order_number)
    OrderMailer.order_complete_mail(@order).deliver
    @order.complete_step!
  end

  private

  def order_number
    "R#{Array.new(ORDER_NUMBER_LENGTH) { rand(10) }.join}"
  end
end

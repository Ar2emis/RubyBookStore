class AddOrderDeliveryService < BaseService
  def initialize(**kwargs)
    super
    @order = kwargs[:order]
    @delivery_type_id = kwargs[:delivery_type_id]
  end

  def call
    delivery_type = DeliveryType.find_by(id: @delivery_type_id)
    return unless delivery_type

    @order.update(total_price: @order.total_price + delivery_type.price, delivery_type: delivery_type)
    @order.payment_step!
  end
end

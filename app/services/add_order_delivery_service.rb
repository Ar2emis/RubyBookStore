class AddOrderDeliveryService < BaseService
  def initialize(**kwargs)
    super
    @order = kwargs[:order]
    @delivery_type_id = kwargs[:delivery_type_id]
  end

  def call
    delivery_type = DeliveryType.find_by(id: @delivery_type_id)
    return unless delivery_type

    @order.delivery_type = delivery_type
    @order.payment_step!
  end
end

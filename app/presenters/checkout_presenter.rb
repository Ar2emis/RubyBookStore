class CheckoutPresenter < BasePresenter
  attr_reader :delivery_types

  def initialize(view:, order:)
    super(view: view)
    @order = order
    @delivery_types = DeliveryType.all
  end

  def current_delivery?(delivery, index)
    @order.delivery_type == delivery || (@order.delivery_type.nil? && index.zero?)
  end
end

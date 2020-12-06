class CheckoutPresenter < BasePresenter
  attr_reader :delivery_types

  def initialize(view:, order:)
    super(view: view)
    @order = order
    @delivery_types = DeliveryType.all
  end

  def current_delivery?(delivery, index)
    (@order.delivery_type.nil? && index.zero?) || @order.delivery_type == delivery
  end

  def states
    %i[addresses delivery payment confirm]
  end

  def last_state?(index)
    states.count - 1 == index
  end
end

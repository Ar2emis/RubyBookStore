class CheckoutPresenter < BasePresenter
  attr_reader :order

  def initialize(view:, order:)
    super(view: view)
    @order = order
  end

  def current_delivery?(delivery, index)
    @order.delivery_type == delivery || (@order.delivery_type.nil? && index.zero?)
  end

  def card
    @order.card || Card.new
  end

  def address(address)
    address || Address.new
  end
end

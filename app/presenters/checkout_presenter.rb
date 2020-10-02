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

  def address_full_name(address)
    "#{address.first_name} #{address.last_name}"
  end

  def address_city_with_zip(address)
    "#{address.city} #{address.zip}"
  end

  def card_last_four_digits
    @order.card.number[-4..]
  end
end

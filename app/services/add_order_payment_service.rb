class AddOrderPaymentService < BaseService
  def initialize(**kwargs)
    super
    @order = kwargs[:order]
    @card_params = kwargs[:card].merge(order: @order)
  end

  def call
    card = Card.create(@card_params)
    return if card.invalid?

    @order.card = card
    @order.confirm_step!
  end
end

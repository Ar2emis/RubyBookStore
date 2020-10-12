class AddOrderPaymentService < BaseService
  def initialize(**kwargs)
    super
    @order = kwargs[:order]
    @card_params = kwargs[:card].merge(order: @order)
  end

  def call
    card_form = CardForm.new(@card_params)
    return if card_form.invalid?

    card_form.submit
    @order.confirm_step!
  end
end

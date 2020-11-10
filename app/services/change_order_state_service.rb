class ChangeOrderStateService < BaseService
  def initialize(**kwargs)
    super
    @order = kwargs[:order]
    @state = kwargs[:state]&.to_sym
  end

  def call
    return unless @order.confirm?

    case @state
    when :addresses then @order.addresses_step!
    when :delivery then @order.delivery_step!
    when :payment then @order.payment_step!
    when :complete then @oder.delivery_step!
    end
  end
end

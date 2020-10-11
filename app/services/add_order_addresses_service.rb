class AddOrderAddressesService < BaseService
  def initialize(**kwargs)
    super
    @order = kwargs[:order]
    @billing_params = kwargs[:billing_address].merge(addressable: @order)
    @shipping_params = kwargs[:only_billing] ? @billing_params : kwargs[:shipping_address].merge(addressable: @order)
  end

  def call
    billing_address = BillingAddress.create(@billing_params)
    shipping_address = ShippingAddress.create(@shipping_params)
    return if billing_address.invalid? || shipping_address.invalid?

    @order.update(billing_address: billing_address, shipping_address: shipping_address)
    @order.delivery_step!
  end
end

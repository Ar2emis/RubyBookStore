class AddOrderAddressesService < BaseService
  def initialize(**kwargs)
    super
    @order = kwargs[:order]
    @billing_params = kwargs[:billing_address].merge(addressable: @order)
    @shipping_params = if kwargs[:only_billing] then @billing_params.merge(address_type: :shipping)
                       else kwargs[:shipping_address].merge(addressable: @order)
                       end
  end

  def call
    billing_address_form = AddressForm.new(@billing_params)
    shipping_address_form = AddressForm.new(@shipping_params)
    return if billing_address_form.invalid? || shipping_address_form.invalid?

    billing_address_form.submit
    shipping_address_form.submit
    @order.delivery_step!
  end
end

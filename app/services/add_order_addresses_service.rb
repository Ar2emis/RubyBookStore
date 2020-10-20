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
    [@billing_params, @shipping_params].each { |params| create_address(params) }
    @order.delivery_step! if success?
  end

  private

  def create_address(params)
    address_form = AddressForm.new(params)
    return @errors = (@errors + address_form.errors.full_messages).uniq if address_form.invalid?

    address_form.submit
  end
end

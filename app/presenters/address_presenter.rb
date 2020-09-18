class AddressPresenter < BasePresenter
  def initialize(user, failed_address = nil)
    super()
    @user = user
    @failed_address = failed_address
  end

  def billing_address
    select_address(Address::BILLING_TYPE)
  end

  def shipping_address
    select_address(Address::SHIPPING_TYPE)
  end

  private

  def select_address(type)
    return @failed_address if @failed_address.present? && @failed_address.address_type == type

    case type
    when Address::SHIPPING_TYPE then @user.shipping_address
    when Address::BILLING_TYPE then @user.billing_address
    end
  end
end

class AddressesController < ApplicationController
  before_action :authenticate_user!

  def update
    @form = AddressForm.new(address_params)
    return if @form.invalid?

    @form.submit
  end

  private

  def address_params
    params.require(:address).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone, :address_type)
          .merge(addressable: current_user)
  end
end

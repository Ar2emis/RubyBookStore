class AddressesController < ApplicationController
  before_action :authenticate_user!

  def update
    @type = address_params[:type]
    @address = Address.find_or_initialize_by(addressable: current_user, type: @type)
    @address.update(address_params)
  end

  private

  def address_params
    params.require(:address).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone, :type)
          .merge(addressable: current_user)
  end
end

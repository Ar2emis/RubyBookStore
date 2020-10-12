class AddressDecorator < ApplicationDecorator
  delegate_all
  delegate :address, to: :object

  def full_name
    "#{first_name} #{last_name}"
  end

  def city_with_zip
    "#{city} #{zip}"
  end
end

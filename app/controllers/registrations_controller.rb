class RegistrationsController < Devise::RegistrationsController
  protect_from_forgery prepend: true
  before_action :countries, :configure_permitted_parameters

  protected

  def without_password?
    params[resource_name][:password].blank?
  end

  def update_resource(resource, params)
    without_password? ? update_resource_without_password(resource, params) : super(resource, params)
  end

  def update_resource_without_password(resource, params)
    params.delete(:current_password)
    resource.update_without_password(params)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) do |user|
      user.permit(:email, :current_password, :password, :password_confirmation,
                  billing_address_attributes: address_attributes,
                  shipping_address_attributes: address_attributes)
    end
  end

  def address_attributes
    %i[first_name last_name address city zip country phone address_type]
  end

  def countries
    @countries = ISO3166::Country.all
  end
end

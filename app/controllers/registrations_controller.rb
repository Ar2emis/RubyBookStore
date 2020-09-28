class RegistrationsController < Devise::RegistrationsController
  protect_from_forgery prepend: true
  before_action :countries, :configure_permitted_parameters

  def quick_create
    resource = build_quick_resource
    if resource.persisted?
      resource.send_reset_password_instructions
      flash[:success] = I18n.t('checkouts.success')
      sign_up(resource_name, resource)
    else
      flash[:error] = I18n.t('checkouts.email_error', errors: resource.errors[:email].join(', '))
    end
    redirect_back(fallback_location: checkout_path)
  end

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

  def build_quick_resource
    password = Devise.friendly_token[0, 20]
    quick_params = sign_up_params.merge(password: password, password_confirmation: password)
    resource = build_resource(quick_params)
    resource.skip_confirmation!
    resource.save
    resource
  end

  def countries
    @countries = ISO3166::Country.all
  end
end

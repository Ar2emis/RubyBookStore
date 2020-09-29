class RegistrationsController < Devise::RegistrationsController
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

  def build_quick_resource
    password = Devise.friendly_token[0, 20]
    quick_params = sign_up_params.merge(password: password, password_confirmation: password)
    resource = build_resource(quick_params)
    resource.skip_confirmation!
    resource.save
    resource
  end
end

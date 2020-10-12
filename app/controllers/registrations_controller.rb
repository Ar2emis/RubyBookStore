class RegistrationsController < Devise::RegistrationsController
  def quick_create
    service = QuickRegistrateService.call(sign_up_params: sign_up_params)
    if service.success?
      flash[:success] = I18n.t('checkouts.success')
      sign_up(resource_name, service.resource)
    else
      flash[:error] = I18n.t('checkouts.email_error', errors: service.errors_message)
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
end

class QuickRegistrationsController < Devise::RegistrationsController
  before_action :require_no_authentication

  def create
    service = QuickRegistrateService.call(sign_up_params: sign_up_params)
    if service.success?
      sign_up(resource_name, service.resource)
      redirect_to(stored_location_for(service.resource), notice: I18n.t('checkouts.success'))
    else
      redirect_to(quick_registration_path, alert: I18n.t('checkouts.email_error', errors: service.errors_message))
    end
  end

  private

  def stored_location_for(resource)
    super || root_path
  end
end

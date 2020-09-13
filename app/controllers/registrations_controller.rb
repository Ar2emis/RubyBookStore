class RegistrationsController < Devise::RegistrationsController
  protect_from_forgery prepend: true

  protected

  def with_password?
    params[resource_name].present? && params[resource_name][:current_password].present?
  end

  def update_resource(resource, params)
    with_password? ? super : resource.update_without_password(params)
  end
end

class RegistrationsController < Devise::RegistrationsController
  # protect_from_forgery prepend: true

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

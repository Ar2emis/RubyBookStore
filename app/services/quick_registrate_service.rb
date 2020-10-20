class QuickRegistrateService < BaseService
  attr_reader :resource

  def initialize(**kwargs)
    super
    @sign_up_params = kwargs[:sign_up_params]
  end

  def call
    build_resource
    @resource.persisted? ? @resource.send_reset_password_instructions : @errors += @resource.errors[:email]
  end

  private

  def build_resource
    @resource = User.new(quick_params)
    @resource.skip_confirmation!
    @resource.save
  end

  def quick_params
    password = Devise.friendly_token[0, 20]
    @sign_up_params.merge(password: password, password_confirmation: password)
  end
end

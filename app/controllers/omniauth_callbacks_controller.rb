class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  FACEBOOK = 'Facebook'.freeze

  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])
    sign_in_and_redirect @user, event: :authentication
    transfer_cart_to_user
    set_flash_message(:notice, :success, kind: FACEBOOK) if is_navigational_format?
  end

  def failure
    redirect_to root_path
    set_flash_message(:error, :failure, kind: FACEBOOK) if is_navigational_format?
  end
end

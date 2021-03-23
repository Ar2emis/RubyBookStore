module Devise
  class NewPage < SitePrism::Page
    set_url '/users/sign_up'

    section :form, '#new_user' do
      element :email, '#user_email'
      element :password, '#user_password'
      element :password_confirmation, '#user_password_confirmation'
      element :sign_up, 'input[type="submit"]'
    end
  end
end

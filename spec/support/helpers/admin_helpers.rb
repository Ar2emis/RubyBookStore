module AdminHelpers
  include ActionView::Helpers

  SHORT_DESCRIPTION_LENGTH = 100

  def admin_log_in
    admin_attributes = attributes_for(:admin_user)
    create(:admin_user, admin_attributes)
    visit '/admin'
    fill_in('admin_user_email', with: admin_attributes[:email])
    fill_in('admin_user_password', with: admin_attributes[:password])
    click_button('Login')
  end

  def short_description(description)
    truncate(description, length: SHORT_DESCRIPTION_LENGTH)
  end
end

RSpec.configure do |config|
  config.include AdminHelpers, type: :feature
end

RSpec.describe 'New', type: :feature do
  before do
    visit new_user_password_path
  end

  context 'with valid input' do
    let(:user) { create(:user) }

    before do
      fill_in(I18n.t('passwords.enter_your_email'), with: user.email)
      click_button(I18n.t('passwords.email_instructions'))
    end

    it 'displays reset instructions' do
      expect(page).to have_content(I18n.t('devise.passwords.send_instructions'))
    end
  end

  context 'with invalid or not registered email' do
    let(:not_registered_email) { '1234' }

    before do
      fill_in(I18n.t('passwords.enter_your_email'), with: not_registered_email)
      click_button(I18n.t('passwords.email_instructions'))
    end

    it 'stays at reset password page' do
      expect(page).to have_current_path(user_password_path)
    end

    it 'displays not found email message' do
      expect(page).to have_content(I18n.t('errors.messages.not_found'))
    end
  end
end

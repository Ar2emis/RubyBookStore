RSpec.describe 'QuickRegistrations Show', type: :feature do
  describe 'sign in form' do
    let(:user_data) { attributes_for(:user) }

    before do
      visit quick_registration_path
      within 'div.col-md-5.mb-40' do
        fill_in(I18n.t('simple_form.placeholders.defaults.email'), with: user_data[:email])
        fill_in(I18n.t('simple_form.placeholders.defaults.password'), with: user_data[:password])
      end
    end

    context 'when user exists' do
      before do
        create(:user, email: user_data[:email], password: user_data[:password])
        click_button(I18n.t('checkouts.log_in_with_password'))
      end

      it 'authorizes user and redirects to home page' do
        expect(page).to have_current_path(root_path)
      end
    end

    context 'with user does not exist' do
      before do
        click_button(I18n.t('checkouts.log_in_with_password'))
      end

      it 'redirects to sign in page' do
        expect(page).to have_current_path(new_user_session_path)
      end

      it 'displays invalid credencials message' do
        expect(page).to have_content(I18n.t('devise.failure.not_found_in_database', authentication_keys: 'Email'))
      end
    end
  end

  describe 'quick registration form' do
    let(:user_data) { attributes_for(:user) }

    before do
      visit quick_registration_path
    end

    context 'when email is valid' do
      before do
        within 'div.col-md-5.col-md-offset-1.mb-60' do
          fill_in(I18n.t('simple_form.placeholders.defaults.email'), with: user_data[:email])
          click_button(I18n.t('checkouts.continue_checkout'))
        end
      end

      it 'registers user and redirects to home page' do
        expect(page).to have_current_path(root_path)
      end
    end

    context 'with email is invalid' do
      before do
        click_button(I18n.t('checkouts.continue_checkout'))
      end

      it 'stays at quick registration page' do
        expect(page).to have_current_path(quick_registration_path)
      end

      it 'displays invalid email message' do
        expect(page).to have_content(I18n.t('checkouts.email_error', errors: I18n.t('errors.messages.blank')))
      end
    end
  end
end

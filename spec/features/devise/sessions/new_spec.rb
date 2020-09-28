RSpec.describe 'New', type: :feature do
  let(:user_data) { attributes_for(:user) }

  before do
    visit new_user_session_path
    fill_in(I18n.t('simple_form.placeholders.defaults.email'), with: user_data[:email])
    fill_in(I18n.t('simple_form.placeholders.defaults.password'), with: user_data[:password])
  end

  context 'with valid input' do
    before do
      create(:user, email: user_data[:email], password: user_data[:password])
      click_button(I18n.t('sessions.sign_in'))
    end

    it 'authorizes user' do
      expect(page).to have_current_path(root_path)
    end
  end

  context 'with invalid input' do
    before do
      click_button(I18n.t('sessions.sign_in'))
    end

    it 'stays at sign in page' do
      expect(page).to have_current_path(new_user_session_path)
    end

    it 'displays invalid credencials message' do
      expect(page).to have_content(I18n.t('devise.failure.not_found_in_database', authentication_keys: 'Email'))
    end
  end
end

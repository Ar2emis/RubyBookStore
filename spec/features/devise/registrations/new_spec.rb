RSpec.describe 'New', type: :feature do
  let(:user_data) { attributes_for(:user) }

  before do
    visit new_user_registration_path
  end

  context 'with valid input' do
    before do
      fill_in(I18n.t('simple_form.placeholders.defaults.email'), with: user_data[:email])
      fill_in(I18n.t('simple_form.placeholders.defaults.password'), with: user_data[:password])
      fill_in(I18n.t('simple_form.placeholders.defaults.password_confirmation'), with: user_data[:password])
      click_button(I18n.t('registrations.sign_up'))
    end

    it 'registers user' do
      expect(page).to have_current_path(root_path)
    end
  end

  context 'with invalid input' do
    let(:invalid_email) { 'abc.com' }
    let(:invalid_password) { '1234' }
    let(:invalid_confirmation_password) { invalid_password.reverse }

    before do
      fill_in(I18n.t('simple_form.placeholders.defaults.email'), with: invalid_email)
      fill_in(I18n.t('simple_form.placeholders.defaults.password'), with: invalid_password)
      fill_in(I18n.t('simple_form.placeholders.defaults.password_confirmation'), with: invalid_confirmation_password)
      click_button(I18n.t('registrations.sign_up'))
    end

    it 'stays at sign up page' do
      expect(page).to have_current_path(user_registration_path)
    end

    it 'displays invalid email message' do
      expect(page).to have_content(I18n.t('activerecord.errors.models.user.attributes.email.invalid'))
    end

    it 'displays invalid password message' do
      expect(page).to have_content(I18n.t('activerecord.errors.models.user.attributes.password.invalid'))
    end

    it 'displays invalid confirmation password message' do
      expect(page).to have_content("doesn't match Password")
    end
  end
end

RSpec.describe 'New', type: :feature do
  let(:current_page) { Devise::NewPage.new }
  let(:user_data) { attributes_for(:user) }

  before do
    current_page.load
  end

  context 'with valid input' do
    before do
      current_page.form.email.fill_in(with: user_data[:email])
      current_page.form.password.fill_in(with: user_data[:password])
      current_page.form.password_confirmation.fill_in(with: user_data[:password])
      current_page.form.sign_up.click
    end

    it 'registers user' do
      expect(current_page).to have_current_path(root_path)
    end
  end

  context 'with invalid input' do
    let(:invalid_email) { 'abc.com' }
    let(:invalid_password) { '1234' }
    let(:invalid_confirmation_password) { invalid_password.reverse }

    before do
      current_page.form.email.fill_in(with: invalid_email)
      current_page.form.password.fill_in(with: invalid_password)
      current_page.form.password_confirmation.fill_in(with: invalid_confirmation_password)
      current_page.form.sign_up.click
    end

    it 'stays at sign up page' do
      expect(current_page).to have_current_path(user_registration_path)
    end

    it 'displays invalid email message' do
      expect(current_page.form).to have_content(I18n.t('activerecord.errors.models.user.attributes.email.invalid'))
    end

    it 'displays invalid password message' do
      expect(current_page.form).to have_content(I18n.t('activerecord.errors.models.user.attributes.password.invalid'))
    end

    it 'displays invalid confirmation password message' do
      expect(current_page.form).to have_content("doesn't match Password")
    end
  end
end

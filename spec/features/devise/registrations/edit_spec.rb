RSpec.describe 'Edit', type: :feature do
  [Address::BILLING_TYPE, Address::SHIPPING_TYPE].each do |type|
    context "with #{type} address" do
      let(:address_data) { attributes_for(:address) }
      let(:user) { create(:user) }

      before do
        sign_in(user)
        visit edit_user_registration_path
      end

      context 'with valid input' do
        before do
          within "##{type}-address" do
            fill_in(I18n.t('addresses.first_name'), with: address_data[:first_name])
            fill_in(I18n.t('addresses.last_name'), with: address_data[:last_name])
            fill_in(I18n.t('addresses.address'), with: address_data[:address])
            fill_in(I18n.t('addresses.city'), with: address_data[:city])
            fill_in(I18n.t('addresses.zip'), with: address_data[:zip])
            page.select(address_data[:country], from: "user_#{type}_address_attributes_country")
            fill_in(I18n.t('addresses.phone_example'), with: address_data[:phone])
            click_button(I18n.t('addresses.save'))
          end
        end

        it "saves #{type} address" do
          expect(page).to have_current_path(root_path)
        end
      end

      context 'with invalid input' do
        before do
          within "##{type}-address" do
            click_button(I18n.t('addresses.save'))
          end
        end

        it 'stays at sign up page' do
          expect(page).to have_current_path(user_registration_path)
        end

        [
          'activerecord.errors.models.address.attributes.first_name.invalid',
          'activerecord.errors.models.address.attributes.last_name.invalid',
          'activerecord.errors.models.address.attributes.city.invalid',
          'activerecord.errors.models.address.attributes.address.invalid',
          'activerecord.errors.models.address.attributes.zip.invalid',
          'activerecord.errors.models.address.attributes.phone.invalid'
        ].freeze.each do |text|
          it { expect(page).to have_content(I18n.t(text)) }
        end
      end
    end
  end

  context 'with password change' do
    let(:user_data) { attributes_for(:user) }

    before do
      user = create(:user, user_data)
      sign_in(user)
      visit edit_user_registration_path
      page.find('#privacy').click
    end

    context 'with valid input' do
      before do
        within '#password-form' do
          fill_in(I18n.t('registrations.old_password'), with: user_data[:password])
          fill_in(I18n.t('registrations.new_password'), with: user_data[:password])
          fill_in(I18n.t('registrations.confirm_password'), with: user_data[:password])
          click_button(I18n.t('registrations.save'))
        end
      end

      it 'saves new password' do
        expect(page).to have_current_path(root_path)
      end
    end

    context 'with invalid input' do
      let(:invalid_password) { '1' }

      before do
        within '#password-form' do
          fill_in(I18n.t('registrations.old_password'), with: invalid_password)
          fill_in(I18n.t('registrations.new_password'), with: invalid_password)
          click_button(I18n.t('registrations.save'))
        end
      end

      [
        I18n.t('errors.messages.invalid'),
        I18n.t('activerecord.errors.models.user.attributes.password.invalid'),
        I18n.t('errors.messages.too_short.other', count: 8),
        I18n.t('errors.messages.confirmation', attribute: 'Password')
      ].each do |text|
        it { expect(page).to have_content(text) }
      end
    end
  end

  context 'with email change' do
    let(:user_data) { attributes_for(:user) }

    before do
      user = create(:user, user_data)
      sign_in(user)
      visit edit_user_registration_path
      page.find('#privacy').click
    end

    context 'with valid input' do
      let(:new_email) { Faker::Internet.email }

      before do
        within '#email-form' do
          fill_in(I18n.t('registrations.enter_email'), with: new_email)
          click_button(I18n.t('registrations.save'))
        end
      end

      it 'saves new email' do
        expect(page).to have_current_path(root_path)
      end
    end

    context 'with invalid input' do
      let(:invalid_email) { 'dasdasd' }

      it 'displays invalid format message' do
        within '#email-form' do
          fill_in(I18n.t('registrations.enter_email'), with: invalid_email)
          click_button(I18n.t('registrations.save'))
        end
        expect(page).to have_content(I18n.t('activerecord.errors.models.user.attributes.email.invalid'))
      end
    end
  end
end

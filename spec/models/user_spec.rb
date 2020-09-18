RSpec.describe User, type: :model do
  describe '.from_omniauth' do
    context 'when user new' do
      let(:auth) { OmniAuth::AuthHash.new(Faker::Omniauth.facebook) }

      it 'creates new user or returns existed' do
        user = described_class.from_omniauth(auth)
        expect(user.uid).to eq auth.uid
      end
    end
  end

  context 'with validations' do
    context 'with password' do
      let(:valid_password) { 'Abcdefg1' }

      it { is_expected.to allow_value(valid_password).for(:password) }

      %w[Abc abcdefg1 ABCDEFG1 Abcdefgh].each do |invalid_password|
        it { is_expected.not_to allow_value(invalid_password).for(:password) }
      end
    end
  end

  context 'with associations' do
    it { is_expected.to belong_to(:billing_address).class_name('Address').optional }
    it { is_expected.to belong_to(:shipping_address).class_name('Address').optional }
    it { is_expected.to accept_nested_attributes_for(:billing_address) }
    it { is_expected.to accept_nested_attributes_for(:shipping_address) }
  end

  context 'with model fields' do
    %i[email encrypted_password provider uid billing_address_id shipping_address_id].each do |field|
      it { is_expected.to have_db_column(field) }
    end
  end
end

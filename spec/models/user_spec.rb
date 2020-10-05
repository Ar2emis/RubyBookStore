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
    it { is_expected.to validate_presence_of(:email) }

    context 'with password' do
      subject(:user) { build(:user) }

      let(:valid_password) { 'Abcdefg1' }

      it 'allows password with one uppercase, downcase letters and digit' do
        expect(user).to allow_value(valid_password).for(:password)
      end

      {
        'Abc' => 'shorter than 8 characters',
        'abcdefg1' => 'without at least 1 uppercase letter',
        'ABCDEFG1' => 'without at least 1 downcase letter',
        'Abcdefgh' => 'without at least 1 digit'
      }.each do |invalid_password, message|
        it "doesn't allow password #{message}" do
          expect(user).not_to allow_value(invalid_password).for(:password)
        end
      end
    end
  end

  context 'with model fields' do
    it { is_expected.to have_db_column(:email) }
    it { is_expected.to have_db_column(:encrypted_password) }
    it { is_expected.to have_db_column(:provider) }
    it { is_expected.to have_db_column(:uid) }
  end
end

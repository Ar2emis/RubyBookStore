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

  describe 'validations' do
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
      }.each do |password, message|
        it "doesn't allow password #{message}" do
          expect(user).not_to allow_value(password).for(:password)
        end
      end
    end
  end
end

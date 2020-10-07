RSpec.describe AddressForm, type: :model do
  describe 'validations' do
    let(:address_attributes) { attributes_for(:address) }

    context 'when successfuly' do
      subject(:address_form) { described_class.new(address_attributes) }

      %i[first_name last_name city country zip address phone address_type].each do |property|
        it { is_expected.to validate_presence_of(property) }
      end

      {
        first_name: described_class::FIFTY_LENGTH,
        last_name: described_class::FIFTY_LENGTH,
        address: described_class::FIFTY_LENGTH,
        city: described_class::FIFTY_LENGTH,
        zip: described_class::ZIP_LENGTH,
        phone: described_class::PHONE_LENGTH
      }.each do |property, max_length|
        it { is_expected.to validate_length_of(property).is_at_most(max_length) }
      end

      it 'validates format' do
        address_attributes.except(:country, :phone).each do |property, valid_value|
          expect(address_form).to allow_value(valid_value).for(property)
        end
      end

      it 'validates that country form the above' do
        address_form.valid?
        expect(address_form.errors[:country]).to be_empty
      end

      it 'validates that phone contains country code' do
        address_form.valid?
        expect(address_form.errors[:phone]).to be_empty
      end
    end

    context 'when failed' do
      let(:country) { 'Urganda' }
      let(:phone) { '+aaa123456789' }

      {
        first_name: '12345678@',
        last_name: '12345678@',
        address: '-%$',
        city: '12345678@',
        zip: 'asdasd'
      }.each do |property, invalid_value|
        it { is_expected.not_to allow_value(invalid_value).for(property) }
      end

      it 'validates that country form the above' do
        address_form = described_class.new({ country: country, phone: phone })
        address_form.valid?
        expect(address_form.errors[:country]).not_to be_empty
      end

      it 'validates that phone contains country code' do
        address_form = described_class.new({ phone: phone })
        address_form.valid?
        expect(address_form.errors[:phone]).not_to be_empty
      end
    end
  end

  describe '#submit' do
    subject(:address_form) { described_class.new(attributes_for(:address).merge(user: create(:user))) }

    it 'creates address' do
      expect(address_form.submit).to be_a Address
    end
  end

  describe '#from_address' do
    let(:address) { build(:address) }

    it 'creates form instance by address attributes' do
      expect(described_class.from_address(address)).to be_a described_class
    end
  end
end

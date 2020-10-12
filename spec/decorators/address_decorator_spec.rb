RSpec.describe AddressDecorator do
  subject(:decorator) { address.decorate }

  let(:address) { build(:address) }

  describe '#full_name' do
    it 'returns address owner full name' do
      full_name = "#{address.first_name} #{address.last_name}"
      expect(decorator.full_name).to eq full_name
    end
  end

  describe '#city_with_zip' do
    it 'returns address city with zip' do
      city_with_zip = "#{address.city} #{address.zip}"
      expect(decorator.city_with_zip).to eq city_with_zip
    end
  end
end

RSpec.describe CardForm, type: :model do
  describe 'validations' do
    subject(:card_form) { described_class.new }

    %i[number name expiration_date cvv].each do |property|
      it { is_expected.to validate_presence_of(property) }
    end

    it 'validates cvv length' do
      expect(card_form).to validate_length_of(:cvv).is_at_least(described_class::MIN_CVV_LENGTH)
                                                   .is_at_most(described_class::MAX_CVV_LENGTH)
    end

    {
      number: { valid: '12345678', invalid: 'abc' },
      name: { valid: 'a b c', invalid: '12345678' },
      expiration_date: { valid: '12/34', invalid: 'abc' },
      cvv: { valid: '1234', invalid: 'abc' }
    }.each do |property, examples|
      it { is_expected.to allow_value(examples[:valid]).for(property) }
      it { is_expected.not_to allow_value(examples[:invalid]).for(property) }
    end
  end

  describe '#submit' do
    subject(:card_form) { described_class.new(attributes_for(:card).merge(order: create(:order))) }

    it 'creates card' do
      expect(card_form.submit).to be_a Card
    end
  end

  describe '#from_card' do
    let(:card) { build(:card) }

    it 'creates form instance by card attributes' do
      expect(described_class.from_card(card)).to be_a described_class
    end
  end
end

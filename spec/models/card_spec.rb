RSpec.describe Card, type: :model do
  context 'with validations' do
    %i[number name expiration_date cvv].each do |property|
      it { is_expected.to validate_presence_of(property) }
    end

    it { is_expected.to validate_length_of(:cvv).is_at_least(Card::MIN_CVV_LENGTH).is_at_most(Card::MAX_CVV_LENGTH) }

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

  context 'with associations' do
    it { is_expected.to belong_to(:order) }
  end

  context 'with model fields' do
    %i[number name expiration_date cvv order_id].each do |field|
      it { is_expected.to have_db_column(field) }
    end
  end
end

RSpec.describe CardDecorator do
  subject(:decorator) { card.decorate }

  let(:card) { build(:card) }

  describe '#last_four_digits' do
    it 'returns last four digits of the card' do
      last_four_digits = card.number[-4..]
      expect(decorator.last_four_digits).to eq last_four_digits
    end
  end
end

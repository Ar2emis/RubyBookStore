RSpec.describe ItemDecorator do
  subject(:decorator) { described_class.decorate(build(:cart_item)) }

  describe '#subtotal' do
    it 'returns price of a book multiplied by count' do
      full_price = decorator.book.price * decorator.amount
      expect(decorator.subtotal).to eq full_price
    end
  end
end

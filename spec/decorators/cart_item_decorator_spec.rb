RSpec.describe CartItemDecorator do
  subject(:decorator) { build(:cart_item).decorate }

  describe '#full_price' do
    it 'returns price of a book multiplied by count' do
      full_price = decorator.book.price * decorator.amount
      expect(decorator.full_price).to eq full_price
    end
  end
end

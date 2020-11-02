RSpec.describe OrderItemDecorator do
  subject(:decorator) { build(:order_item).decorate }

  describe '#subtotal' do
    it 'returns price of a book multiplied by count' do
      subtotal = decorator.book.price * decorator.quantity
      expect(decorator.subtotal).to eq subtotal
    end
  end
end

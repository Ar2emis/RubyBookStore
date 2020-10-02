RSpec.describe BestSellersQuery do
  describe '.call' do
    let(:order) { create(:order, state: :in_queue) }
    let(:order_items) { create_list(:order_item, order_items_amount, order: order) }
    let(:not_selled_books) { create_list(:book, order_items_amount) }
    let(:order_items_amount) { 3 }

    it 'returns best selled books' do
      books = order_items.map(&:book).sort_by(&:id)
      queried_books = described_class.call(order_items_amount).sort_by(&:id)
      expect(queried_books).to eq books
    end

    it 'does not return books which not selled' do
      queried_books = described_class.call(order_items_amount * 2)
      expect(queried_books & not_selled_books).to be_empty
    end
  end
end

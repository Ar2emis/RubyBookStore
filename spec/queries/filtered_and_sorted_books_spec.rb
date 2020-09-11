RSpec.describe FilteredAndSortedBooks do
  describe '.query' do
    context 'with filtering' do
      let(:category) { create(:category) }
      let(:category_book) { create(:book, category: category) }
      let(:another_category_book) { create(:book) }

      it 'filters books by category' do
        books = described_class.query(category: category)
        expect(books).to include(category_book)
      end

      it 'returns only chosen category books' do
        books = described_class.query(category: category)
        expect(books).not_to include(another_category_book)
      end
    end

    context 'with sorting' do
      let(:sort_parameter) { :atoz }
      let(:books_amount) { 10 }

      before do
        create_list(:book, books_amount)
      end

      it 'sorts books by sort parameter' do
        books_titles = described_class.query(sort: sort_parameter).map(&:title)
        sorted_books_titles = Book.order(:title).map(&:title)
        expect(books_titles).to eq sorted_books_titles
      end
    end
  end
end

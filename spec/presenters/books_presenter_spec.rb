require 'rails_helper'

RSpec.describe BooksPresenter do
  subject(:presenter) { described_class.new(view: fake_view, books: books, categories: [category], params: params) }

  let(:books_amount) { 5 }
  let(:category) { create(:category) }
  let(:sort) { described_class::SORT_PARAMETERS.keys.first }
  let(:books) { create_list(:book, books_amount) }
  let(:params) { { category: category.id, sort: sort } }

  describe '#sort_parameters' do
    it 'returns parameters hash' do
      expect(presenter.sort_parameters).to eq described_class::SORT_PARAMETERS
    end
  end

  describe '#current_category' do
    it 'returns current category name' do
      expect(presenter.current_category).to eq category.name
    end
  end

  describe '#display_params' do
    it 'returns grouped into a hash category and sort' do
      expect(presenter.display_params).to eq params
    end
  end

  describe '#current_sort' do
    context 'when sort specified' do
      it 'returns current sort name if sort specified' do
        expect(presenter.current_sort).to eq described_class::SORT_PARAMETERS[sort]
      end
    end

    context 'when sort does not specified' do
      subject(:presenter) do
        described_class.new(view: fake_view, books: books,
                            categories: [category], params: { category: category.id })
      end

      it 'returns sort by newest' do
        expect(presenter.current_sort).to eq described_class::SORT_PARAMETERS[:newest]
      end
    end
  end

  describe '#no_category_chosen_class' do
    subject(:no_category_presenter) do
      described_class.new(view: fake_view, books: books,
                          categories: [category], params: {})
    end

    it 'returns current category class when no category chosen' do
      expect(no_category_presenter.no_category_chosen_class).to eq described_class::CHOSEN_CATEGORY_CLASS
    end

    it 'returns nil when category chosen' do
      expect(presenter.no_category_chosen_class).to be_nil
    end
  end

  describe '#chosen_category_class' do
    it 'returns current category class when category chosen' do
      expect(presenter.chosen_category_class(category)).to eq described_class::CHOSEN_CATEGORY_CLASS
    end

    it 'returns nil when another category chosen' do
      expect(presenter.chosen_category_class(build(:category))).to be_nil
    end
  end

  describe '#all_books_count' do
    it 'returns all books count' do
      expect(presenter.all_books_count).to eq books_amount
    end
  end
end

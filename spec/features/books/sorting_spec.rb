require 'rails_helper'

RSpec.describe 'Sorting', type: :feature do
  let(:books_amount) { 10 }
  let!(:books) { create_list(:book, books_amount, price: Faker::Number.decimal) }

  before do
    visit books_path
  end

  context 'with default sort' do
    it 'displays newest books first' do
      books_titles = books.sort_by(&:created_at).map(&:title)
      displayed_titles = page.all('p.title').map(&:text)
      expect(books_titles).to eq displayed_titles
    end
  end

  context 'with sort selected' do
    {
      I18n.t('books.sort.cheap') => :price,
      I18n.t('books.sort.atoz') => :title,
      I18n.t('books.sort.expensive') => { price: :desc },
      I18n.t('books.sort.ztoa') => { title: :desc }
    }.each do |sort_name, property|
      it "displays books sorted by '#{sort_name}}'" do
        within('.hidden-xs.clearfix') { click_link(sort_name) }
        books_titles = Book.order(property).limit(BooksController::BOOKS_AMOUNT).map(&:title)
        displayed_titles = page.all('p.title').map(&:text)
        expect(books_titles).to eq displayed_titles
      end
    end
  end
end

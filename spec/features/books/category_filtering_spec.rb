require 'rails_helper'

RSpec.describe 'Category filtering', type: :feature do
  let!(:category) { create(:category) }
  let(:category_books_amount) { 3 }
  let!(:category_books) { create_list(:book, category_books_amount, category: category) }
  let(:other_books_amount) { 3 }
  let!(:other_books) { create_list(:book, other_books_amount) }

  before do
    visit books_path
  end

  context 'without category selected' do
    it 'displays all books' do
      (category_books + other_books).each do |book|
        expect(page).to have_content(book.title)
      end
    end
  end

  context 'with category selected' do
    before do
      within('ul.list-inline.pt-10.mb-25.mr-240') { click_link(category.name) }
    end

    it 'displays only category books' do
      category_books.each do |book|
        expect(page).to have_content(book.title)
      end
    end

    it "does't display others books" do
      other_books.each do |book|
        expect(page).not_to have_content(book.title)
      end
    end
  end
end

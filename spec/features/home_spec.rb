require 'rails_helper'

RSpec.describe 'Home', type: :feature do
  context 'with slider' do
    let!(:books) { BookDecorator.decorate_collection(create_list(:book, HomeController::LATEST_BOOKS_AMOUNT)) }

    before do
      visit root_path
    end

    it "has #{HomeController::LATEST_BOOKS_AMOUNT} books indicators" do
      within('ol.carousel-indicators') { expect(page).to have_selector('li', count: books.count) }
    end

    it 'has books data' do
      books.each do |book|
        expect(page).to have_content(book.title)
        expect(page).to have_content(book.description)
        expect(page).to have_content(book.authors_names)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe 'Home', type: :feature do
  describe 'with slider' do
    let!(:books) { BookDecorator.decorate_collection(create_list(:book, StaticPagesController::LATEST_BOOKS_AMOUNT)) }

    before do
      visit root_path
    end

    it "has #{StaticPagesController::LATEST_BOOKS_AMOUNT} books indicators" do
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

  describe 'best sellers' do
    let(:order) { create(:order, state: :in_queue) }
    let!(:order_items) { create_list(:order_item, order_items_amount, order: order) }
    let(:order_items_amount) { 3 }

    before do
      visit root_path
    end

    it 'displays best selled books' do
      order_items.map { |item| item.book.title }.each do |title|
        expect(page).to have_content(title)
      end
    end
  end
end

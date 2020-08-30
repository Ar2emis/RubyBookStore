require 'rails_helper'

RSpec.describe 'home/partials/_slider.html.haml', type: :view do
  let(:latest_books) { build_list(:book, HomeController::LATEST_BOOKS_AMOUNT) }

  before do
    assign(:latest_books, latest_books)
    render
  end

  it "displays #{HomeController::LATEST_BOOKS_AMOUNT} slider indicators" do
    (0...latest_books.count).each do |index|
      expect(rendered).to match(/data-slide-to='#{index}'/)
    end
  end

  it "displays #{HomeController::LATEST_BOOKS_AMOUNT} slider items" do
    expect(rendered).to have_css('.carousel-item.item', count: latest_books.count)
  end
end

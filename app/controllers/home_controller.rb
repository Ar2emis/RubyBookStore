class HomeController < ApplicationController
  LATEST_BOOKS_AMOUNT = 3

  def index
    @latest_books = BookDecorator.decorate_collection(LatestBooks.new(amount: LATEST_BOOKS_AMOUNT).to_a)
  end
end

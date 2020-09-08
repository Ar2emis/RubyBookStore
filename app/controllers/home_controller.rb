class HomeController < ApplicationController
  LATEST_BOOKS_AMOUNT = 3

  def index
    @latest_books = LatestBooks.new(LATEST_BOOKS_AMOUNT).query.decorate
  end
end

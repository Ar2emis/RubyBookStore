class HomeController < ApplicationController
  LATEST_BOOKS_AMOUNT = 3

  def index
    @latest_books = LatestBooks.query(LATEST_BOOKS_AMOUNT).decorate
  end
end

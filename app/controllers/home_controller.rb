class HomeController < ApplicationController
  LATEST_BOOKS_AMOUNT = 3

  def index
    @latest_books = Book.latest.limit(LATEST_BOOKS_AMOUNT)
  end
end

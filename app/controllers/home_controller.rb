class HomeController < ApplicationController
  LATEST_BOOKS_AMOUNT = 3

  def index
    @latest_books = Book.includes([:authors]).last(LATEST_BOOKS_AMOUNT)
  end
end

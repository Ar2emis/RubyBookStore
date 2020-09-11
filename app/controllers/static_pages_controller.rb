class StaticPagesController < ApplicationController
  LATEST_BOOKS_AMOUNT = 3

  def home
    @latest_books = LatestBooksQuery.call(LATEST_BOOKS_AMOUNT).decorate
  end
end

class StaticPagesController < ApplicationController
  LATEST_BOOKS_AMOUNT = 3

  def home
    @latest_books = LatestBooks.query(LATEST_BOOKS_AMOUNT).decorate
  end
end

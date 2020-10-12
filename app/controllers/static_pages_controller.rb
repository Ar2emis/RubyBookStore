class StaticPagesController < ApplicationController
  LATEST_BOOKS_AMOUNT = 3
  BEST_SELLERS_AMOUNT = 4

  def home
    @latest_books = LatestBooksQuery.call(LATEST_BOOKS_AMOUNT).decorate
    @bestsellers = BookDecorator.decorate_collection(BestSellersQuery.call(BEST_SELLERS_AMOUNT))
  end
end

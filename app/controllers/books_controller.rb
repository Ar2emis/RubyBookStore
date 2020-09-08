class BooksController < ApplicationController
  include Rectify::ControllerHelpers
  BOOKS_AMOUNT = 12

  def index
    present BooksPresenter.new(books: prepared_books, categories: @categories)
  end

  def show
    present BookPresenter.new(book: Book.find(book_param).decorate)
  end

  private

  def prepared_books
    FilteredAndSortedBooks.new(category: category_param, sort: sort_param, amount: books_amount).query.decorate
  end

  def books_amount
    count = params[:count].to_i
    count.positive? ? count * BOOKS_AMOUNT : BOOKS_AMOUNT
  end

  def sort_param
    params[:sort]
  end

  def category_param
    params[:category]
  end

  def book_param
    params[:id]
  end
end

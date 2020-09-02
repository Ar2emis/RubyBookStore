class BooksController < ApplicationController
  BOOKS_AMOUNT = 12

  def index
    @books = prepared_books
  end

  def show
    @book = Book.find(book_param)
  end

  private

  def prepared_books
    Book.with_authors.where(category_param).limit(books_amount).ordered(sort_param)
  end

  def books_amount
    helpers.next_count * BOOKS_AMOUNT
  end

  def sort_param
    params[:sort]
  end

  def category_param
    params.permit(:category)
  end

  def book_param
    params[:id]
  end
end

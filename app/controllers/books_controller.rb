class BooksController < ApplicationController
  include Pagy::Backend
  include Rectify::ControllerHelpers

  def show
    present BookPresenter.new(book: Book.find(book_param).decorate)
  end

  def index
    @pagy, books = pagy_countless(prepared_books, link_extra: 'data-remote="true"')
    present BooksPresenter.new(books: books, categories: @categories)
  end

  private

  def prepared_books
    FilteredAndSortedBooks.query(category: category_param, sort: sort_param).decorate
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

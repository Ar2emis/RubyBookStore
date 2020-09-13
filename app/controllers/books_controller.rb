class BooksController < ApplicationController
  include Pagy::Backend

  def show
    book = Book.find_by(book_param)
    book.nil? ? redirect_to(books_path) : @presenter = BookPresenter.new(book: book.decorate)
  end

  def index
    @pagy, books = pagy_countless(prepared_books, link_extra: 'data-remote="true"')
    @presenter = BooksPresenter.new(books: books, categories: @categories, params: params)
  end

  private

  def prepared_books
    FilteredAndSortedBooksQuery.call(display_params).decorate
  end

  def display_params
    params.permit(:sort, :category).to_h.symbolize_keys
  end

  def book_param
    params.permit(:id)
  end
end

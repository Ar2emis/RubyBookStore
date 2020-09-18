class BooksController < ApplicationController
  include Pagy::Backend

  def show
    book = Book.find_by(book_param)
    book.nil? ? redirect_to(books_path) : @presenter = BookPresenter.new(view: view_context, book: book.decorate)
  end

  def index
    @pagy, books = pagy_countless(prepared_books, link_extra: 'data-remote="true"')
    @presenter = BooksPresenter.new(view: view_context, books: books, categories: @categories, params: params)
  end

  private

  def prepared_books
    FilteredAndSortedBooksQuery.call(category: category_param, sort: sort_param).decorate
  end

  def sort_param
    params[:sort]
  end

  def category_param
    params[:category]
  end

  def book_param
    params.permit(:id)
  end
end

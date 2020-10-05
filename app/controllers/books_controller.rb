class BooksController < ApplicationController
  include Pagy::Backend

  def show
    book = Book.find_by(id: params[:id])
    return @presenter = BookPresenter.new(view: view_context, book: book.decorate) if book.present?

    redirect_to(books_path, alert: I18n.t('books.book_not_found'))
  end

  def index
    @pagy, books = pagy_countless(prepared_books, link_extra: 'data-remote="true"')
    @presenter = BooksPresenter.new(view: view_context, books: books, categories: @categories, params: params)
  end

  private

  def prepared_books
    FilteredAndSortedBooksQuery.call(category: params[:category], sort: params[:sort]).decorate
  end
end

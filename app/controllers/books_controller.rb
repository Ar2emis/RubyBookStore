class BooksController < ApplicationController
  include Pagy::Backend

  def show
    book = Book.with_attached_title_image.with_attached_images.find_by(book_param)
    return redirect_to(books_path) if book.nil?

    @presenter = BookPresenter.new(view: view_context, book: book.decorate)
  end

  def index
    @pagy, books = pagy_countless(prepared_books, link_extra: 'data-remote="true"')
    @presenter = BooksPresenter.new(view: view_context, books: books, categories: @book_categories, params: params)
  end

  private

  def prepared_books
    FilteredAndSortedBooksQuery.call(display_params).with_attached_title_image.decorate
  end

  def display_params
    params.permit(:sort, :category).to_h.symbolize_keys
  end

  def book_param
    params.permit(:id)
  end
end

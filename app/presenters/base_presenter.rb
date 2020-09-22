class BasePresenter
  DEFAULT_BOOK_IMAGE = 'default_book.png'.freeze

  def initialize(view:)
    @view = view
  end

  def title_image_url(book)
    book.title_image.attached? ? book.title_image_url : @view.image_url(DEFAULT_BOOK_IMAGE)
  end
end

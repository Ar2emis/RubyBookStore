class BasePresenter
  DEFAULT_BOOK_IMAGE = 'default_book.png'.freeze

  def initialize(view:)
    @view = view
  end
end

class BookPresenter < BasePresenter
  attr_reader :book

  SHORT_DESCRIPTION_MAX_LENGTH = 250

  def initialize(book:)
    super()
    @book = book
  end

  def description_long?
    @book.description.length > SHORT_DESCRIPTION_MAX_LENGTH
  end

  def short_description
    view.truncate(@book.description, length: SHORT_DESCRIPTION_MAX_LENGTH)
  end
end

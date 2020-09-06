class BookPresenter < Rectify::Presenter
  attribute :book, BookDecorator
  SHORT_DESCRIPTION_MAX_LENGTH = 250

  def description_long?
    @book.description.length > SHORT_DESCRIPTION_MAX_LENGTH
  end

  def short_description
    truncate(@book.description, length: SHORT_DESCRIPTION_MAX_LENGTH)
  end
end

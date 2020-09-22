class BookPresenter < BasePresenter
  attr_reader :book, :reviews

  SHORT_DESCRIPTION_MAX_LENGTH = 250

  def initialize(view:, book:)
    super(view: view)
    @book = book
    @reviews = @book.reviews.where(status: :approved).with_user
  end

  def description_long?
    @book.description.length > SHORT_DESCRIPTION_MAX_LENGTH
  end

  def short_description
    @view.truncate(@book.description, length: SHORT_DESCRIPTION_MAX_LENGTH)
  end

  def title_image_url
    super(@book)
  end
end

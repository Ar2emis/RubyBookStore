class FilteredAndSortedBooks < Rectify::Query
  def initialize(category: nil, sort: nil, amount:)
    @category = category
    @sort = sort
    @amount = amount
    super
  end

  def query
    books = Book.with_authors.where(nil)
    books = books.where(category: @category) if @category.present?
    books = books.ordered(@sort) if @sort.present?
    books.limit(@amount)
  end
end

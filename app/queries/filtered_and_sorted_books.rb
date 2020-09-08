class FilteredAndSortedBooks < Rectify::Query
  def initialize(category: nil, sort: nil, amount: nil)
    @category = category
    @sort = sort
    @amount = amount
    super
  end

  def query
    books = Book.with_authors.where(nil)
    books = books.where(category: @category) if @category.present?
    books = books.ordered(@sort) if @sort.present?
    books = books.limit(@amount) if @amount.present?
    books
  end
end

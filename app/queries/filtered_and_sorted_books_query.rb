class FilteredAndSortedBooksQuery
  def self.call(category: nil, sort: nil)
    books = Book.all
    books = books.where(category: category) if category.present?
    books = books.ordered(sort) if sort.present?
    books.with_authors
  end
end

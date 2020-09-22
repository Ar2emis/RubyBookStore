class FilteredAndSortedBooksQuery
  def self.call(category: nil, sort: nil)
    books = Book.all
    books = books.where(category: category) if category.present?
    books = books.ordered(sort.to_sym) if sort.present?
    books
  end
end

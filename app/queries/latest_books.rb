class LatestBooks < Rectify::Query
  def initialize(amount:)
    @amount = amount
    super
  end

  def query
    Book.with_authors.last(@amount).reverse
  end
end

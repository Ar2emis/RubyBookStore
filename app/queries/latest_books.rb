class LatestBooks < Rectify::Query
  def initialize(amount)
    @amount = amount
    super
  end

  def query
    Book.with_authors.order(created_at: :desc).limit(@amount)
  end
end

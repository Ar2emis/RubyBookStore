class LatestBooks
  def self.query(amount)
    Book.with_authors.order(created_at: :desc).limit(amount)
  end
end

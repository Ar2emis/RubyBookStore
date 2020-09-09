class LatestBooks
  def self.query(amount)
    Book.order(created_at: :desc).limit(amount)
  end
end

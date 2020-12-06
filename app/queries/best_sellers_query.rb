class BestSellersQuery
  def self.call
    Book.includes(:authors).joins(order_items: :order).merge(Order.finished_by_user).group(:id)
        .select('books.*', 'COUNT(*) as order_items_count').order(order_items_count: :desc).uniq(&:category_id)
  end
end

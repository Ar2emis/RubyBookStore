class BestSellersQuery
  def self.call(amount)
    OrderItem.joins(:order).merge(Order.finished_by_user).group(:book).count.max(amount).map(&:first)
  end
end

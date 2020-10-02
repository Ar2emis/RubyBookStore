class BestSellersQuery
  def self.call(amount)
    books = OrderItem.joins(:order).merge(Order.finished_by_user).group(:book).count.max(amount).map(&:first)
    ActiveRecord::Associations::Preloader.new.preload(books, [:authors, { title_image_attachment: :blob }])
    books
  end
end

class OrderDecorator < ApplicationDecorator
  delegate_all
  decorates_associations :order_items

  def ordered_order_items
    order_items.includes(:book).order(:created_at)
  end

  def subtotal_price
    order_items.sum(&:full_price)
  end

  def coupon_sale
    coupon ? coupon.sale : 0.0
  end

  def total_price
    total = subtotal_price - coupon_sale
    total.negative? ? 0.0 : total
  end
end

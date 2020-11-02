class OrderDecorator < ApplicationDecorator
  delegate_all
  decorates_associations :order_items

  def ordered_order_items
    order_items.includes(:book).order(:created_at)
  end

  def subtotal
    order_items.sum(&:subtotal)
  end

  def discount
    coupon&.sale || 0.0
  end

  def total_price
    total = subtotal - discount
    total.negative? ? 0.0 : total
  end
end

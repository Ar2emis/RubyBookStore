class PriceDecorator < ApplicationDecorator
  def subtotal(items)
    items.includes(:book).inject(0) { |sum, item| sum + item.subtotal }
  end

  def discount
    coupon&.sale || 0.0
  end
end

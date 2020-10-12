class PriceDecorator < ApplicationDecorator
  def subtotal(items)
    items.includes(:book).sum(&:subtotal)
  end

  def discount
    coupon&.sale || 0.0
  end
end

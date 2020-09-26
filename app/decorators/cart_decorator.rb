class CartDecorator < ApplicationDecorator
  delegate_all
  decorates_associations :cart_items

  def ordered_cart_items
    cart_items.order(:created_at)
  end

  def subtotal_price
    cart_items.inject(0) { |sum, item| sum + item.full_price }
  end

  def coupon_sale
    coupon ? coupon.sale : 0.0
  end

  def total_price
    total = subtotal_price - coupon_sale
    total.negative? ? 0.0 : total
  end
end

class CartDecorator < PriceDecorator
  delegate_all
  decorates_associations :cart_items

  def ordered_cart_items
    cart_items.order(:created_at)
  end

  def subtotal
    super(cart_items)
  end

  def total_price
    total = subtotal - discount
    total.negative? ? 0.0 : total
  end
end

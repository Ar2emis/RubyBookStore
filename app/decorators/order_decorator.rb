class OrderDecorator < ApplicationDecorator
  delegate_all
  decorates_associations :order_items, :billing_address, :shipping_address, :card

  def ordered_order_items
    order_items.includes(:book).order(:created_at)
  end

  def subtotal
    order_items.sum(&:subtotal)
  end

  def discount
    coupon&.sale || 0.0
  end

  def delivery_price
    delivery_type&.price || 0.0
  end

  def total_price
    total = subtotal + delivery_price - discount
    total.negative? ? 0.0 : total
  end

  def formated_updated_at
    updated_at.strftime('%B %d, %Y')
  end

  def state_done?(state)
    state_before_type_cast > Order.states[state]
  end

  def current_state?(state)
    self.state == state.to_s
  end
end

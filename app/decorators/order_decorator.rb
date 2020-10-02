class OrderDecorator < PriceDecorator
  delegate_all
  decorates_associations :order_items

  def prepared_order_items
    order_items.includes(book: :title_image_attachment)
  end

  def subtotal
    super(order_items)
  end
end

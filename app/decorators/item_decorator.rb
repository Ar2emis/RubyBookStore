class ItemDecorator < ApplicationDecorator
  delegate_all
  decorates_association :book

  def subtotal
    book.price * amount
  end
end

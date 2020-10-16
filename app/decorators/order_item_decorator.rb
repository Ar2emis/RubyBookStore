class OrderItemDecorator < ApplicationDecorator
  delegate_all
  decorates_association :book

  def full_price
    book.price * amount
  end
end

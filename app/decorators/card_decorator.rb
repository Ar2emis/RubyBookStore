class CardDecorator < ApplicationDecorator
  delegate_all

  LAST_DIGITS_AMOUNT = 4

  def last_four_digits
    number[-LAST_DIGITS_AMOUNT..]
  end
end

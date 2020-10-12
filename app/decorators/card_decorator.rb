class CardDecorator < ApplicationDecorator
  delegate_all

  def last_four_digits
    number[-4..]
  end
end

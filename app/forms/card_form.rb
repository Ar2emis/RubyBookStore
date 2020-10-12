class CardForm < BaseForm
  NUMERIC_FORMAT = /\A\d+\z/.freeze
  TEXT_FORMAT = /\A[a-zA-Z\s]+\z/.freeze
  DATE_FORMAT = %r/\A(0[1-9]|10|11|12)\/[0-9]{2}\z/.freeze
  MIN_CVV_LENGTH = 3
  MAX_CVV_LENGTH = 4

  validates :number, :name, :expiration_date, :cvv, presence: true
  validates :number, format: { with: NUMERIC_FORMAT }
  validates :name, format: { with: TEXT_FORMAT }
  validates :expiration_date, format: { with: DATE_FORMAT }
  validates :cvv, format: { with: NUMERIC_FORMAT }, length: { minimum: MIN_CVV_LENGTH, maximum: MAX_CVV_LENGTH }

  attr_accessor :number, :name, :expiration_date, :cvv, :order

  def self.from_card(card)
    return new unless card

    card_attributes = card.attributes.except('id', 'order_id', 'created_at', 'updated_at')
    new(card_attributes)
  end

  def submit
    order.card = Card.new(@params)
  end
end

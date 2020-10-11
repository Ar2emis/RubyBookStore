class Order < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :coupon, optional: true
  has_many :order_items, dependent: :destroy
  has_one :billing_address, as: :addressable, dependent: :destroy
  has_one :shipping_address, as: :addressable, dependent: :destroy
  has_one :order_delivery_type, dependent: :destroy
  has_one :delivery_type, through: :order_delivery_type
  has_one :card, dependent: :destroy

  scope :in_progress, -> { where(state: %i[in_queue in_delivery]) }
  scope :delivered, -> { where(state: :delivered) }
  scope :canceled, -> { where(state: :canceled) }

  aasm column: :state do
    state :addresses, initial: true
    state :delivery, :payment, :confirm, :complete,
          :in_queue, :in_delivery, :delivered, :canceled

    event(:addresses_step)   { transitions from: :confirm, to: :addresses }
    event(:delivery_step)    { transitions from: %i[addresses confirm], to: :delivery }
    event(:payment_step)     { transitions from: %i[delivery confirm], to: :payment }
    event(:confirm_step)     { transitions from: :payment, to: :confirm }
    event(:complete_step)    { transitions from: :confirm, to: :complete }
    event(:in_queue_step)    { transitions from: :complete, to: :in_queue }
    event(:in_delivery_step) { transitions from: :in_queue, to: :in_delivery }
    event(:delivered_step)   { transitions from: %i[in_queue in_delivery], to: :delivered }
    event(:canceled_step)    { transitions from: %i[in_queue in_delivery delivered], to: :canceled }
  end
end

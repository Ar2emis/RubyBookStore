class OrderDeliveryType < ApplicationRecord
  belongs_to :order
  belongs_to :delivery_type
end

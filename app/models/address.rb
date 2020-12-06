class Address < ApplicationRecord
  enum address_type: { billing: 0, shipping: 1 }

  belongs_to :addressable, polymorphic: true
end

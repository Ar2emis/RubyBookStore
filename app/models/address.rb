class Address < ApplicationRecord
  enum address_type: { billing: 0, shipping: 1 }

  belongs_to :user

  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, :address_type, presence: true
end

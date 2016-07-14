class Address < ApplicationRecord
  belongs_to :country
  validates :firstname, :lastname, :street_address, :city, :zip, :phone, :country, presence: true

  alias_attribute :street, :street_address
end

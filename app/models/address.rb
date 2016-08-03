class Address < ApplicationRecord
  FORMAT_ZIP = /\A\d{5}\z/
  FORMAT_PHONE = /\A\+?\d{10,14}\z/
  belongs_to :country
  validates :firstname, :lastname, :street_address, :city, :zip, :phone, :country, presence: true
  validates :zip, format: FORMAT_ZIP
  validates :phone, format: FORMAT_PHONE
  alias_attribute :street, :street_address
end

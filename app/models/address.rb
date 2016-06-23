class Address < ApplicationRecord
  belongs_to :country
  validates :firstname,:lastname, :street_address, :city, :zip, :phone, :country_id, presence: true

  alias_attribute :street, :street_address

  def full_name
    "#{firstname} #{lastname}"
  end

  def self.attributes_list
    [:id, :firstname,:lastname, :street_address, :city, :zip, :phone, :country_id]
  end
end

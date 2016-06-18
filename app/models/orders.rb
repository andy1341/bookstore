class Order < ApplicationRecord
  belongs_to :user
  belongs_to :billing_address, class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'
  belongs_to :delivery
  belongs_to :credit_card
  has_many :orders_items


end

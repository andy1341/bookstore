class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  belongs_to :billing_address, class_name: 'Address', dependent: :destroy
  belongs_to :shipping_address, class_name: 'Address', dependent: :destroy
  belongs_to :credit_card, dependent: :destroy
  has_many :orders, dependent: :destroy

  accepts_nested_attributes_for :billing_address
  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :credit_card

  include Facebookable

  def order_in_progress
    return orders.in_progress.last unless orders.in_progress.empty?
    orders.new
  end
end

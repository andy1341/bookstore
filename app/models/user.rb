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

  include Facebook

  def current_order
    orders.in_progress.last if orders.in_progress
  end

end

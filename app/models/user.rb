class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :orders, dependent: :destroy

  include Contactable
  include Facebookable

  def order_in_progress
    return orders.in_progress.last unless orders.in_progress.empty?
    orders.new
  end
end

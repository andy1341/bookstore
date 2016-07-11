class Coupon < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :discount, inclusion: 1..100

  def discount_coefficient
    (1 - discount/100.0)
  end
end

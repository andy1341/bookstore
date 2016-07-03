class OrdersItem < ApplicationRecord
  belongs_to :book
  belongs_to :order

  validates :count, presence: true, format: {with:/\d{1,2}/}
  validate :validate_cost, on: create
  validates :book, presence: true
  validates :order, presence: true
  validates :book, uniqueness: {scope: :order_id}

  before_create :set_cost
  after_save :order_update

  def total
    return 0 if cost.nil?
    count*cost
  end

  def order_update
    order.save
  end

  def set_cost
    self[:cost] = book.price
  end

  private
  def validate_cost
    errors.add(:cost, 'A cost must equal to book cost') if cost != book.cost
  end
end

class Order < ApplicationRecord
  belongs_to :user
  belongs_to :billing_address, class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'
  belongs_to :delivery
  belongs_to :credit_card
  has_many :orders_items, -> { order(created_at: :desc) }, dependent: :destroy

  before_save :set_total

  delegate :empty?, to: :orders_items

  include AASM

  enum status: {
      in_progress: 1,
      awaiting_shipment: 2,
      shipped: 3,
      completed: 4,
      cancelled: 5
  }

  aasm :column => :status, :enum => true do
    state :in_progress, :initial => true
    state :awaiting_shipment, :shipped, :completed, :cancelled

    event :make_order do
      transitions from: :in_progress, to: :awaiting_shipment
    end

    event :shipped do
      transitions from: :awaiting_shipment, to: :shipped
    end

    event :complete do
      transitions from: :shipped, to: :completed
    end

    event :cancel do
      transitions from: [:in_progress, :awaiting_shipment, :shipped]
    end

  end

  def set_total
    self[:total] = orders_items.sum(&:total)
  end

  def << (other)
    other.orders_items.each do |item|
      item.update_attribute(:order, self) unless orders_items.find_by_book_id(item.book_id)
    end
    other.reload.destroy
    self
  end

end

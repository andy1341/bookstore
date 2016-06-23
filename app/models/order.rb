class Order < ApplicationRecord
  belongs_to :user
  belongs_to :billing_address, class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'
  belongs_to :delivery
  belongs_to :credit_card
  has_many :orders_items, -> { order(created_at: :desc) }, dependent: :destroy
  scope :shipped, -> {where(status:'shipped')}
  scope :completed, -> {where(status:'completed')}
  scope :cancelled, -> {where(status:'cancelled')}
  accepts_nested_attributes_for :billing_address
  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :credit_card

  before_save :set_total
  delegate :empty?, to: :orders_items

  include AASM

  aasm :column => :status, :whiny_transitions => false do
    state :in_progress, initial: true
    state :awaiting_shipment, :shipped, :completed, :cancelled

    event :make_order do
      transitions from: :in_progress, to: :awaiting_shipment, guard: :can_make_order?
    end

    event :shipped do
      transitions from: :awaiting_shipment, to: :shipped
    end

    event :complete do
      transitions from: :shipped, to: :completed, success: :mark_complete
    end

    event :cancel do
      transitions from: [:in_progress, :awaiting_shipment, :shipped]
    end

  end

  def can_make_order?
    errors.add(:base, "Order already done") unless in_progress?
    errors.add(:user, :blank) if user.blank?
    errors.add(:billing_address, :blank) if billing_address.blank?
    errors.add(:shipping_address, :blank) if !use_billing_address && shipping_address.blank?
    errors.add(:delivery, :blank) if delivery.blank?
    errors.add(:credit_card, :blank) if credit_card.blank?
    errors.add(:orders_items, :blank) if orders_items.blank?
    errors.empty?
  end

  def mark_complete
    update(completed: Date.today)
  end

  def set_total
    self[:total] = total
  end

  def subtotal
    orders_items.sum(&:total)
  end

  def total
    delivery.nil? ? subtotal : subtotal+delivery.cost
  end

  def << (other)
    other.orders_items.each do |item|
      item.update_attribute(:order, self) unless orders_items.find_by_book_id(item.book_id)
    end
    other.reload.destroy
    self
  end

end

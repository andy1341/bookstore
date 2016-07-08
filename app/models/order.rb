class Order < ApplicationRecord
  belongs_to :user
  belongs_to :billing_address, class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'
  belongs_to :delivery
  belongs_to :credit_card
  has_many :orders_items, -> { order(created_at: :desc) }, dependent: :destroy

  attr_accessor :active_admin_requested_event

  delegate :empty?, to: :orders_items
  delegate :billing_address, to: :user, prefix:true
  delegate :shipping_address, to: :user, prefix:true
  delegate :credit_card, to: :user, prefix:true

  before_save :set_total
  after_initialize do
    if user.present?
      self.billing_address ||= user_billing_address.dup
      self.shipping_address ||= user_shipping_address.dup
      self.credit_card ||= user_credit_card
    end
  end

  enum status: [:in_progress, :awaiting_shipment, :shipped, :completed, :cancelled]

  include AASM

  aasm :column => :status, enum:true, :whiny_transitions => false do
    state :in_progress, initial: true
    state :awaiting_shipment
    state :shipped
    state :completed
    state :cancelled

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
      transitions from: [:in_progress, :awaiting_shipment, :shipped], to: :cancelled
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
    update(completed_date: Date.today)
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

  def union_with(other)
    other.orders_items.each do |item|
      item.update_attribute(:order, self) unless contains(item.book)
    end
    other.reload.destroy
    self
  end

  def contains(book)
    !!orders_items.find_by_book_id(book.id)
  end

end

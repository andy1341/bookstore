class Order < ApplicationRecord
  belongs_to :user
  belongs_to :delivery
  belongs_to :coupon
  has_many :orders_items, -> { order(created_at: :desc) }, dependent: :destroy

  validates :user, presence: true, unless: :in_progress?
  validates :billing_address_id, presence: true, unless: :in_progress?
  validates :shipping_address_id, presence: true, if: :validate_shipping?
  validates :delivery, presence: true, unless: :in_progress?
  validates :credit_card_id, presence: true, unless: :in_progress?
  validates :orders_items, presence: true, unless: :in_progress?

  include Contactable

  DEFAULT_DISCOUNT_COEFFICIENT = 1
  TEMPORARY_LIVE_DURATION = 1.day
  attr_accessor :active_admin_requested_event

  delegate :empty?, to: :orders_items
  delegate :billing_address, to: :user, prefix: true
  delegate :shipping_address, to: :user, prefix: true
  delegate :credit_card, to: :user, prefix: true

  before_save :set_total

  scope :temporary, -> {where('user_id is NULL AND created_at < ?', TEMPORARY_LIVE_DURATION.ago)}

  enum status: [:in_progress, :awaiting_shipment, :shipped, :completed, :cancelled]

  include AASM

  aasm column: :status, enum: true, whiny_transitions: false do
    state :in_progress, initial: true
    state :awaiting_shipment
    state :shipped
    state :completed
    state :cancelled

    event :make_order do
      transitions from: :in_progress, to: :awaiting_shipment
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

  def mark_complete
    update(completed_date: Date.today)
  end

  def set_total
    self[:total] = total
  end

  def amount
    orders_items.sum(&:total)
  end

  def subtotal
    amount * discount
  end

  def apply_coupon(coupon)
    update(coupon: coupon) if coupon.is_a? Coupon
  end

  def discount
    return coupon.discount_coefficient if coupon.present?
    DEFAULT_DISCOUNT_COEFFICIENT
  end

  def total
    delivery.nil? ? subtotal : subtotal + delivery.cost
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

  private

  def validate_shipping?
    !in_progress? && !use_billing_address
  end
end

module Contactable
  extend ActiveSupport::Concern

  included do
    belongs_to :billing_address, class_name: 'Address', dependent: :destroy
    belongs_to :shipping_address, class_name: 'Address', dependent: :destroy
    belongs_to :credit_card, dependent: :destroy

    accepts_nested_attributes_for :billing_address
    accepts_nested_attributes_for :shipping_address
    accepts_nested_attributes_for :credit_card
  end

  def billing_address
    super || copy_field(:billing_address) || build_billing_address
  end

  def shipping_address
    super || copy_field(:shipping_address) || build_shipping_address
  end

  def credit_card
    super || copy_field(:credit_card) || build_credit_card
  end

  private

  def copy_field(field)
    try(:user).try(field).try(:dup).try(:save)
  end
end

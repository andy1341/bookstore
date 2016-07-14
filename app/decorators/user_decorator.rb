class UserDecorator < Drape::Decorator
  delegate_all
  decorates_association :billing_address, with: AddressDecorator
  decorates_association :shipping_address, with: AddressDecorator
  decorates_association :credit_card
  decorates_association :user

  def to_s
    object.email
  end
end

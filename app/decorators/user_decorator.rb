class UserDecorator < Drape::Decorator
  delegate_all
  decorates_association :billing_address, with: AddressDecorator
  decorates_association :shipping_address, with: AddressDecorator
end

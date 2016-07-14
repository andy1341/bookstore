class UserDecorator < Draper::Decorator
  delegate_all
  decorates_association :billing_address, with: AddressDecorator
  decorates_association :shipping_address, with: AddressDecorator
  decorates_association :credit_card
  decorates_association :user

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def to_s
    object.email
  end
end

class CreditCardDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def to_s
    h.content_tag(:div, "**** **** **** #{object.number.to_s.last(4)}")+
    h.content_tag(:div, "#{object.expiration_month}/#{object.expiration_year}")
  end

end

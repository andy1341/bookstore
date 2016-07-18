class CreditCardDecorator < Drape::Decorator
  delegate_all

  def to_s
    h.content_tag(:div, "**** **** **** #{object.number.to_s.last(4)}") +
      h.content_tag(:div,
                    "#{object.expiration_month}/#{object.expiration_year}")
  end
end

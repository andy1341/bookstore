module ApplicationHelper
  def categories
    @categories = Category.with_books
  end

  def icon(name)
    tag('span', class: "glyphicon glyphicon-#{name}")
  end

  def print_address(address)
    content_tag(:div) do
      content_tag(:div, address.full_name) +
          content_tag(:div, address.street) +
          content_tag(:div, address.city) +
          content_tag(:div, address.country) +
          content_tag(:div, "Phone: #{address.phone}")
    end
  end

  def print_credit_card(credit_card)
    content_tag(:div, "**** **** **** #{credit_card.number.to_s.last(4)}") +
        content_tag(:div,
                      "#{credit_card.expiration_month}/#{credit_card.expiration_year}")
  end
end

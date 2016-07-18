class AddressDecorator < Drape::Decorator
  delegate_all

  def full_name
    "#{object.firstname} #{object.lastname}"
  end

  def to_s
    h.content_tag :div do
      h.content_tag(:div, full_name) +
        h.content_tag(:div, object.street) +
        h.content_tag(:div, object.city) +
        h.content_tag(:div, object.country) +
        h.content_tag(:div, "Phone: #{object.phone}")
    end
  end
end

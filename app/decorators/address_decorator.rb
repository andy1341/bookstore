class AddressDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

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

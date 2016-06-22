module CartsHelper
  def in_cart book
    current_order.orders_items.map(&:book).include? book
  end

  def tab_header(name, enable = true, active = false)
    result = <<HTML
<li role="presentation" class="#{active ? 'active ' : ''}#{enable ? '' : 'disabled'}">
  <a href="##{name}" aria-controls="#{name}" role="tab" data-toggle='tab' >#{name.humanize}</a>
</li>
HTML
    result.html_safe
  end
end

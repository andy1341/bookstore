module CartsHelper
  def in_cart book
    current_order.orders_items.map(&:book).include? book
  end
end

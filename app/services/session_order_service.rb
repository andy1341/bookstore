class SessionOrderService
  def self.union_with_user_order(session, user)
    session_order = Order.find_by_id(session[:order_id])
    user.order_in_progress.union_with session_order if session_order.present?
    session[:order_id] = user.order_in_progress.id
  end
end

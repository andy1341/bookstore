class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_order

  before_action :configure_device, if: :devise_controller?

  def after_sign_in_path_for(resource_or_scope)
    current_order_update
    user_path
  end

  def current_order
    session[:order_id] ||= Order.create.id
    Order.find(session[:order_id])
  end

  protected

  def current_order_update
    user_order = current_user.orders.in_progress.last
    if user_order.nil?
      current_order.update_attribute(:user, current_user)
    else
      user_order << current_order
      session[:order_id] = user_order.id
    end
  end

  def configure_device
    @user ||= User.new
    @user.billing_address ||= Address.new
    @user.shipping_address ||= Address.new

    devise_parameter_sanitizer.permit(:account_update, keys: [
        :id, billing_address_attributes: Address.attributes_list,
        shipping_address_attributes: Address.attributes_list
    ])
  end
end

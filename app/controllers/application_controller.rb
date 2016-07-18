class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order, :set_user

  before_action :configure_device, if: :devise_controller?
  before_action :set_breadcrumbs

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :notice => exception.message
  end

  def current_order
    order = current_user.order_in_progress if current_user
    order ||= Order.find_by_id(session[:order_id])
    order || new_session_order
  end

  protected

  def new_session_order
    order = Order.create(user: current_user)
    session[:order_id] = order.id
    order
  end

  def configure_device
    set_user
    devise_parameter_sanitizer.permit(:account_update, keys: [
                                        :id, billing_address_attributes: Address.attribute_names,
                                             shipping_address_attributes: Address.attribute_names,
                                             credit_card_attributes: [:id, :number, :code, :expiration_month, :expiration_year]
                                      ])
  end

  def set_user
    @user ||= User.new
  end

  def set_breadcrumbs; end
end

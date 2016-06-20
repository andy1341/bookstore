class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_order

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :init, if: :devise_controller?

  def current_order
    if session[:order_id].nil?
      Order.new
    else
      Order.find(session[:order_id])
    end
  end

  protected

  def init
    @user ||= User.new
    @user.billing_address ||= Address.new
    @user.shipping_address ||= Address.new
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [
        :id, billing_address_attributes: address_attributes,
        shipping_address_attributes: address_attributes
    ])
  end

  def address_attributes
    [:id, :firstname,:lastname, :street_address, :city, :zip, :phone, :country_id]
  end
end

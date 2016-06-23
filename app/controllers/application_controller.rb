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
    order = Order.find_by_id(session[:order_id])
    order || new_session_order
  end

  protected

  def new_session_order
    order = Order.create(user:current_user)
    session[:order_id] = order.id
    order
  end

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
    @user.credit_card ||= CreditCard.new

    if params[:user]
      params[:user].delete(:shipping_address_attributes) if empty_address?(:shipping)
      params[:user].delete(:billing_address_attributes) if empty_address?(:billing)
      params[:user].delete(:credit_card_attributes) if empty_card?
    end

    devise_parameter_sanitizer.permit(:account_update, keys: [
        :id, billing_address_attributes: Address.attributes_list,
        shipping_address_attributes: Address.attributes_list,
        credit_card_attributes: [:number, :code, :expiration_month, :expiration_year]
        ])
  end

  def empty_address?(type)
    params.require(:user).fetch(:"#{type}_address_attributes",{})
        .permit([:firstname,:lastname,:street_address,:city,:zip,:phone]).values.all?(&:empty?)
  end

  def empty_card?
    params[:user][:credit_card_attributes][:number].empty? if params[:user][:credit_card_attributes]
    false
  end
end

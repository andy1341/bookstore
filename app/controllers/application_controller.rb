class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_order, :set_user

  before_action :configure_device, if: :devise_controller? || :registrations_controller?
  before_action :set_breadcrumbs

  def after_sign_in_path_for(resource_or_scope)
    if is_a?(ActiveAdmin::Devise::SessionsController)
      super
    else
      current_order_update
      checkout_path
    end
  end

  def after_acount_update_path_for(resource_or_scope)
    user_path
  end

  def current_order
    order = current_user.current_order if current_user
    order ||= Order.find_by_id(session[:order_id])
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
    set_user
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

  def set_user
    @user ||= User.new
    @user.billing_address ||= Address.new
    @user.shipping_address ||= Address.new
    @user.credit_card ||= CreditCard.new
  end

  def empty_address?(type)
    params.require(:user).fetch(:"#{type}_address_attributes",{})
        .permit([:firstname,:lastname,:street_address,:city,:zip,:phone]).values.all?(&:empty?)
  end

  def empty_card?
    return params[:user][:credit_card_attributes][:number].empty? if params[:user][:credit_card_attributes]
    false
  end

  private
  def set_breadcrumbs

  end
end

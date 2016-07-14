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
    if params[:user]
      params[:user].delete(:shipping_address_attributes) if empty_address?(:shipping)
      params[:user].delete(:billing_address_attributes) if empty_address?(:billing)
      params[:user].delete(:credit_card_attributes) if empty_card?
    end

    devise_parameter_sanitizer.permit(:account_update, keys: [
                                        :id, billing_address_attributes: Address.attribute_names,
                                             shipping_address_attributes: Address.attribute_names,
                                             credit_card_attributes: [:id, :number, :code, :expiration_month, :expiration_year]
                                      ])
  end

  def set_user
    @user ||= User.new
  end

  def empty_address?(type)
    params.require(:user).fetch(:"#{type}_address_attributes", {})
          .permit([:firstname, :lastname, :street_address, :city, :zip, :phone]).values.all?(&:empty?)
  end

  def empty_card?
    params[:user][:credit_card_attributes].nil? || params[:user][:credit_card_attributes][:number].empty?
  end

  def set_breadcrumbs; end
end

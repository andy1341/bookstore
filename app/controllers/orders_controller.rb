class OrdersController < ApplicationController
  before_action :set_order, except: [:show]
  before_action :authenticate_user!
  before_action do
    redirect_to(user_path) unless request.format.js?
  end
  def update
    @next_step = params[:order][:next_step].to_sym
    params[:order][:use_billing_address] ||= @order.use_billing_address
    params[:order][:use_billing_address] = ["1",true].include? params[:order][:use_billing_address]
    params[:order][:shipping_address_attributes] = nil if params[:order][:use_billing_address]
    @order.update(order_params)
  end

  def make_order
    return new_session_order if @order.make_order && @order.save
    @order.errors.add(:base, "Can't make order")
  end

  def show
    @order = current_user.orders.find_by_id(params[:id])
    redirect_to(user_path) if @order.nil?
  end

  private
  def set_order
    @order = current_order
  end
  def order_params
    params.require(:order).permit(
        :use_billing_address,
        :delivery_id,
        billing_address_attributes: Address.attribute_names,
        shipping_address_attributes: Address.attribute_names,
        credit_card_attributes: [
            :number,
            :code,
            :expiration_month,
            :expiration_year,
            :id
        ]
    )
  end
end
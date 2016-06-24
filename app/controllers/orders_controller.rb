class OrdersController < ApplicationController

  def update
    @order = current_order
    @next_step = params[:order][:next_step]
    params[:order][:use_billing_address] ||= @order.use_billing_address
    params[:order][:use_billing_address] = ["1",true].include? params[:order][:use_billing_address]
    params[:order][:shipping_address_attributes] = nil if params[:order][:use_billing_address]
    @order.update(order_params)
  end

  def make_order
    if @order.make_order && @order.save
      new_session_order
    else
      @order.errors.add(:base, "Can't make order")
    end
  end

  def show
    @order = Order.find_by_id(params[:id])
  end

  private
  def order_params
    params.require(:order).permit(
        :use_billing_address,
        :delivery_id,
        billing_address_attributes: Address.attributes_list,
        shipping_address_attributes: Address.attributes_list,
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
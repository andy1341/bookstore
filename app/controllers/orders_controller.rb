class OrdersController < ApplicationController

  def update
    @order = current_user.orders.find(params[:id])
    params[:order][:use_billing_address] = params[:order][:use_billing_address] == "1"
    params[:order][:shipping_address_attributes] = nil if params[:order][:use_billing_address]
    @order.update(order_params)
  end

  private
  def order_params
    params.require(:order).permit(
        :use_billing_address,
        billing_address_attributes: Address.attributes_list,
        shipping_address_attributes: Address.attributes_list
    )
  end
end
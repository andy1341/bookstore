class CartsController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @order = current_order
  end

  def checkout
    @order = current_order
    redirect_to cart_path if @order.orders_items.empty?
    @deliveries = Delivery.all

    @order.billing_address ||= @order.user.billing_address ?
        @order.user.billing_address.dup :
        Address.new
    @order.shipping_address ||= @order.user.shipping_address ?
        @order.user.shipping_address.dup :
        Address.new
    @order.credit_card ||= @order.user.credit_card ?
        @order.user.credit_card.dup :
        CreditCard.new
  end
end

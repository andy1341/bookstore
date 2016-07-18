class CartsController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @order = current_order
  end

  def checkout
    @order = current_order
    redirect_to cart_path if @order.orders_items.empty?
    @deliveries = Delivery.all
    take_user_fields
  end

  private

  def take_user_fields
    @order.billing_address = @order.user.billing_address.dup if @order.billing_address.id.nil?
    @order.shipping_address = @order.user.shipping_address.dup if @order.shipping_address.id.nil?
    @order.credit_card = @order.user.credit_card.dup if @order.credit_card.id.nil?
  end
end

class CartsController < ApplicationController
  before_action :set_var
  before_action :authenticate_user!, except: [:show]

  def show
  end

  def checkout
    redirect_to cart_path if @orders_items.empty?
    @order.billing_address ||= @order.user.billing_address.dup
    @order.shipping_address ||= @order.user.shipping_address.dup
  end

  private

  def set_var
    @order = current_order
    @orders_items = @order.orders_items
    @deliveries = Delivery.all
  end
end

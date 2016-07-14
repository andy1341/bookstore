class CartsController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @order = current_order
  end

  def checkout
    @order = current_order
    redirect_to cart_path if @order.orders_items.empty?
    @deliveries = Delivery.all
  end
end

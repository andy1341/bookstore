class CartsController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @order = current_order
  end

  def checkout
    @order = current_order
    @deliveries = Delivery.all
    redirect_to cart_path if @orders_items.empty?
  end
end

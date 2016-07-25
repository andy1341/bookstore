class OrdersController < ApplicationController
  load_and_authorize_resource

  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find_by_id(params[:id])
  end
end

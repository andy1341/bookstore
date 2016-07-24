class OrdersController < ApplicationController
  load_and_authorize_resource

  def show
    @order = Order.find_by_id(params[:id])
  end
end

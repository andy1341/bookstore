class OrdersItemsController < ApplicationController
  load_and_authorize_resource
  before_action :set_order
  before_action :find_item, only: [:update, :destroy]
  respond_to :json

  def create
    @order_item = @order.orders_items.create(create_params)
  end

  def update
    @order_item.update(update_params)
  end

  def destroy
    @order_item.destroy
  end

  private

  def create_params
    params.require(:orders_item).permit(:count, :book_id)
  end

  alias_method :update_params, :create_params

  def set_order
    @order = current_order
  end

  def find_item
    @order_item = @order.orders_items.find_by_id(params[:id])
  end
end

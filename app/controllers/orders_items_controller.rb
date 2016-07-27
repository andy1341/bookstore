class OrdersItemsController < ApplicationController
  before_action :set_order
  before_action :find_item, only: [:update, :destroy]
  respond_to :json

  def create
    @order_item = @order.orders_items.create(order_item_params)
  end

  def update
    @order_item.update(order_item_params)
  end

  def destroy
    @order_item.destroy
  end

  private

  def order_item_params
    params.require(:orders_item).permit(:count, :book_id)
  end

  def set_order
    @order = current_order
  end

  def find_item
    @order_item = @order.orders_items.find_by_id(params[:id])
  end
end

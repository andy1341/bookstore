class OrdersItemsController < ApplicationController
  before_action :set_order
  after_action :update_order

  def create
    @order_item = @order.orders_items.new(order_item_params)
    @order.save
    @book = Book.find(order_item_params[:book_id])
  end

  def update
    @order_item = @order.orders_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @orders_items = @order.orders_items
  end

  def destroy
    @order_item = @order.orders_items.find(params[:id])
    @order_item.destroy
    @orders_items = @order.orders_items
  end

  private
  def order_item_params
    params.require(:orders_item).permit(:count, :book_id)
  end

  def update_order
    @order.save
  end

  def set_order
    @order = current_order
  end

end

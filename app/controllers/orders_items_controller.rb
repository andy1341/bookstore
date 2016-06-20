class OrdersItemsController < ApplicationController
  after_action :update_order

  def create
    @order = current_order
    @order_item = @order.orders_items.new(order_item_params)
    @order.save
    session[:order_id] = @order.id
    @book = Book.find(order_item_params[:book_id])
  end

  def update
    @order = current_order
    @order_item = @order.orders_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @orders_items = @order.orders_items
  end

  def destroy
    @order = current_order
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

  def render_cart
    render partial:'carts/cart_content', locals: {items:@orders_items}
  end
end

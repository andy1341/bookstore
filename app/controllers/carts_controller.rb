class CartsController < ApplicationController
  before_action :set_var
  before_action :authenticate_user!, except: [:show]

  def show
  end

  def checkout
    redirect_to cart_path if @orders_items.empty?

    @order.billing_address ||= @order.user.billing_address ?
        @order.user.billing_address.dup :
        Address.new
    @order.shipping_address ||= @order.user.shipping_address ?
        @order.user.shipping_address.dup :
        Address.new
    @order.credit_card ||= @order.user.credit_card ?
        @order.user.credit_card.dup :
        CreditCard.new
  end

  private

  def set_var
    @order = current_order.decorate
    @orders_items = @order.orders_items
    @deliveries = Delivery.all
  end
end

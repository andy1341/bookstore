class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :assign_form

  def show
    redirect_to cart_path if current_order.empty?
    @deliveries = Delivery.all
  end

  def update
    @form.save
    respond_to :json
  end

  private

  def assign_form
    @form = CheckoutForm.new(order_params)
  end

  def order_params
    params
      .fetch(:checkout_form,{})
      .permit(:step,
              :use_billing_address,
              :delivery_id,
              billing_address_attributes: Address.attribute_names,
              shipping_address_attributes: Address.attribute_names,
              credit_card_attributes: [:number,
                                       :code,
                                       :expiration_month,
                                       :expiration_year,
                                       :id])
      .merge(order:current_order)
  end
end
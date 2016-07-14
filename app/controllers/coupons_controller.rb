class CouponsController < ApplicationController
  def apply
    @coupon = Coupon.find_by_name(coupon_params[:name])
    @order = current_order
    current_order.apply_coupon(@coupon)
    respond_to do |f|
      f.html do
        flash[:notice] = I18n.t('coupons.apply.invalid_coupon')
        redirect_to cart_path
      end
      f.js
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:name)
  end
end

require 'rails_helper'

RSpec.describe CouponsController, type: :controller do

  describe "PATCH #apply" do
    let(:coupon) {create(:coupon)}
    let(:order) {create(:order)}
    before do
      allow(controller).to receive(:current_order) {order}
    end
    it "assigns coupon" do
      patch :apply, params: {coupon:{name:coupon.name}}
      expect(assigns(:coupon)).to eq coupon
    end

    it 'reditect to cart as :html' do
      patch :apply, params: {coupon:{name:coupon.name}}
      expect(response).to redirect_to cart_path
    end

    it 'render :apply, as :js' do
      patch :apply,format: :js, params: {coupon:{name:coupon.name}}
      expect(response).to render_template :apply
    end
  end

end

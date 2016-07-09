require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:order) {create(:order)}

  before do
    allow(controller).to receive(:current_order).and_return(order)
  end

  describe 'GET #show' do
    before { get :show }

    it 'render :show' do
      expect(response).to render_template(:show)
    end

    it 'assign @order' do
      expect(assigns(:order)).to eq(order)
    end
  end

  describe 'GET #checkout' do
    subject {get :checkout}

    context 'not signed in' do
      it "redirect to new_user_session_path" do
        is_expected.to redirect_to(new_user_session_path)
      end
    end

    context 'signed in' do
      login_user

      context 'order empty' do
        it 'redirect to cart' do
          order.update(orders_items: [])
          is_expected.to redirect_to(cart_path)
        end
      end

      it 'assign @order' do
        get :checkout
        expect(assigns(:order)).to eq(order)
      end
    end
  end
end

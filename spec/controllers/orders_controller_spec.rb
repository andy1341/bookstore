require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user) }
  let(:order) { create(:order, user: user) }
  before { allow(controller).to receive(:current_order).and_return(order) }
  before { allow(controller).to receive(:current_user).and_return(user) }
  login_user

  describe 'GET #show' do
    subject { get :show, params: { id: order.id } }

    it 'assign order' do
      subject
      expect(assigns(:order)).to be_a Order
    end

    context 'foreign order'
    it 'redirect to home' do
      order.update(user:create(:user))
      is_expected.to redirect_to(root_path)
    end
  end

  describe 'PATCH make_order' do
    after { patch :make_order, format: :js }

    it 'create new session order when order ready' do
      allow(order).to receive(:make_order).and_return(true)
      allow(order).to receive(:save).and_return(true)
      expect(controller).to receive(:new_session_order)
    end

    it 'add errors when order not ready' do
      allow(order).to receive(:make_order).and_return(false)
      allow(order).to receive(:save).and_return(false)
      expect(order).to receive_message_chain(:errors, :add)
    end
  end

  describe 'PUT update' do
    def js_request
      put :update, format: :js, params: {
        id: order.id,
        order: {
          next_step: :delivery,
          delivery_id: 2
        }
      }
    end

    it 'assigns @next_step' do
      js_request
      expect(assigns(:next_step)).to eq :delivery
    end
    it 'update order' do
      expect(order).to receive(:update)
      js_request
    end
  end
end

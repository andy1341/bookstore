require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:order) { create(:order) }

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
end

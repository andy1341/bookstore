require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe 'GET #show' do

    let(:book) {create(:book)}

    before do
      allow(controller).to receive(:current_order).and_return(Order.new)
      get :show, params: { id: book.id }
    end

    it 'renders :show template' do
      expect(response).to render_template(:show)
    end

    it 'assigns @author' do
      expect(assigns(:book)).to eq book
      expect(assigns(:orders_item)).to be_a OrdersItem
    end

    it 'add breadcrumbs' do
      expect(controller).to receive(:add_breadcrumb).twice
      get :show, params: { id: book.id }
    end

  end
end

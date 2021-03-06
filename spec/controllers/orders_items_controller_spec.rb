require 'rails_helper'

RSpec.describe OrdersItemsController, type: :controller do
  let(:order) { create(:order) }
  let(:book) { create(:book) }
  let(:orders_item) { create(:orders_item, book: book, order: order) }

  before { allow(controller).to receive(:current_order) { order } }

  describe 'POST create' do
    let(:action) do
      post :create, format: :json, params: {
        orders_item: {
          book_id: book.id,
          count: 1
        }
      }
    end

    it 'increase orders_items count' do
      expect { action }.to change { order.orders_items.count }.by 1
    end
  end

  describe 'PUT update' do
    let(:action) do
      put :update, format: :json, params: {
        id: orders_item.id,
        orders_item: {
          count: 2
        }
      }
    end
    it 'update order item' do
      action
      expect(assigns(:order_item).count).to eq 2
    end
  end

  describe 'DELETE destroy' do
    let(:action) do
      delete :destroy, format: :json, params: {
        id: orders_item.id
      }
    end
    it 'decrease order items count' do
      order.orders_items << orders_item
      expect { action }.to change { order.orders_items.count }.by(-1)
    end
  end
end

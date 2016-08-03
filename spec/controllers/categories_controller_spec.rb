require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:book) { create(:book) }
  let(:category) { book.category }

  describe 'GET #show' do
    before do
      get :show, params: { id: category.id }
    end

    it 'assigns category' do
      expect(assigns(:category)).to eq(category)
    end
    it 'assigns books' do
      expect(assigns(:books)).to eq([book])
    end
    it 'render :show' do
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #index' do
    before do
      get :index
    end

    it 'assigns books' do
      expect(assigns(:books)).to eq([book])
    end

    it 'render :index' do
      expect(response).to render_template(:index)
    end
  end
end

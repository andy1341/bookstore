require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe 'GET #show' do
    let(:book) { create(:book) }
    let(:category) { book.category }

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
end

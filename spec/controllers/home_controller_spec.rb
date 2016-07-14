require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do
    it 'renders :index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns @best_sellers' do
      expect(Book).to receive(:popular_books)
      get :index
    end
  end
end

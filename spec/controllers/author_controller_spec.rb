require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  describe 'GET #show' do

    let(:author) {create(:author)}

    before do
      get :show, params: { id: author.id }
    end

    it 'renders :show template' do
      expect(response).to render_template(:show)
    end

    it 'assigns @author' do
      expect(assigns(:author)).to eq author
    end

  end
end

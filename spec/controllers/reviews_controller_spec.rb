require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  describe 'POST create' do
    let(:action) do
      post :create, format: :js, params: {
          review:attributes_for(:review)
      }
    end

    context 'not logged in' do
      it 'respond with 401' do
        action
        expect(response).to have_http_status :unauthorized
      end
    end

    context 'logged in' do
      login_user

      it 'assigns review' do
        action
        expect(assigns(:review)).to be_a Review
      end
      it 'create review with :review_params' do
        allow(controller).to receive(:review_params) {:review_params}
        expect(Review).to receive(:create).with(:review_params)
        action
      end
    end

  end
end

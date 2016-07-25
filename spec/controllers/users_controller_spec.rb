require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #show' do
    context 'not logged in' do
      before(:each) { get :show }
      it 'redirect to login page' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'logged in' do
      login_user
      before(:each) { get :show }

      it 'assigns @user' do
        expect(assigns(:user)).to be_a User
      end

      it 'render :show' do
        expect(response).to render_template :show
      end
    end
  end
end

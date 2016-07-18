require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  let(:user) { create(:user) }
  before { configure_omniauth }

  describe 'get #facebook' do
    context 'user present' do
      before do
        allow(User).to receive(:from_omniauth) { user }
        get :facebook
      end

      it 'sign in' do
        expect(controller.current_user).to eq user
      end

      it 'redirect' do
        expect(response).to redirect_to root_path
      end
    end

    context 'user not present' do
      before do
        allow(User).to receive(:from_omniauth) { nil }
        get :facebook
      end
      it 'save data to session' do
        expect(controller.session['devise.facebook_data']).to be_truthy
      end
      it 'redirect to new_user_registration' do
        expect(response).to redirect_to new_user_registration_path
      end
    end
  end
end

require 'rails_helper'

feature 'Sign in' do

  let(:user) {create(:user)}

  context 'valid user data' do
    scenario 'Log in' do
      sign_in(user)
      expect(page).to have_content(I18n.t 'devise.sessions.signed_in')
    end

    scenario 'Log out' do
      sign_in(user)
      click_on(I18n.t('menu.logout'))
      expect(page).to have_content(I18n.t 'devise.sessions.signed_out')
    end
  end

  context 'invalid user data' do
    scenario 'show errors' do
      user.password = '12'
      sign_in(user)
      expect(page).to have_content(I18n.t('devise.failure.not_found_in_database', authentication_keys: :Email))
    end
  end

  context 'facebook' do
    scenario 'log in' do
      mock_auth
      visit new_user_session_path
      click_on(I18n.t('devise.shared.links.sign_with', with: :Facebook))
      expect(page).to have_content(I18n.t('devise.omniauth_callbacks.success', kind: :Facebook))
    end
  end
end
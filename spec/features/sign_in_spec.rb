require 'rails_helper'

feature 'Sign in' do

  let(:user) {create(:user)}

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
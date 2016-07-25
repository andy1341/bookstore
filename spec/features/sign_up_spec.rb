require 'rails_helper'

feature 'Sign up' do
  before { visit new_user_registration_path }
  context 'valid data' do
    scenario 'sign up' do
      fill_in 'Email', with: FFaker::Internet.email
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_on 'Sign up'
      expect(page).to have_content(I18n.t('devise.registrations.signed_up'))
    end
  end
  context 'invalid data' do
    it 'show errors' do
      click_on 'Sign up'
      expect(page).to have_css('#error_explanation')
    end
  end
end

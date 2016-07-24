require 'rails_helper'

feature 'Checkout', checkout: true do
  let(:book) { create(:book) }
  let(:user) { create(:user) }
  let(:credit_card_attributes) { attributes_for(:credit_card) }
  let(:address_attributes) { attributes_for(:address) }
  before do
    sign_in(user)
    create_list(:country, 3)
    create_list(:delivery, 3)
    visit_cart_with(book)
    click_on I18n.t('carts.cart_content.make-order')
    check 'checkout_form[use_billing_address]'
  end

  scenario 'click Use billing address' do
    expect(page).to have_css('.shipping-address', visible: false)
  end

  scenario 'fill all', js: true do
    fill_address_step
    fill_delivery_step
    fill_payment_step
    fill_confirm_step
    fill_complete_step
  end
end

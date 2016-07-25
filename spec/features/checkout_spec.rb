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
  end

  scenario 'click Use billing address' do
    check 'checkout_form[use_billing_address]'
    expect(page).to have_css('.shipping-address', visible: false)
  end

  scenario 'empty address attributes', js: true do
    fill_address_step
    checkout_continue
    expect(page).to have_css('.alert')
    expect(page).to have_content("can't be blank")
  end

  scenario 'invalid credit card number', js: true do
    check 'checkout_form[use_billing_address]'
    fill_address_step(address_attributes)
    checkout_continue
    fill_delivery_step
    fill_payment_step({number:1233,code:123})
    checkout_continue
    expect(page).to have_css('.alert')
    expect(page).to have_content('number is invalid')
  end

  context 'fill address with valid data' do
    scenario 'use billing address', js: true do
      check 'checkout_form[use_billing_address]'
      fill_address_step(address_attributes)
      checkout_continue
      expect_tab(:delivery)
    end

    scenario 'without use billing address', js: true do
      fill_address_step(address_attributes)
      fill_address_step(address_attributes, 'shipping')
      checkout_continue
      expect_tab(:delivery)
    end
  end

  scenario 'full checkout filling', js: true do
    check 'checkout_form[use_billing_address]'
    fill_address_step(address_attributes)
    checkout_continue
    expect_tab(:delivery)
    fill_delivery_step
    fill_payment_step(credit_card_attributes)
    checkout_continue
    expect_tab(:confirm)
    fill_confirm_step
    fill_complete_step
  end
end

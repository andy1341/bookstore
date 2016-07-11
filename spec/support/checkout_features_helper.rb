module CheckoutFeaturesHelper

  def fill_address_step
    within '.tab-pane.active .billing-address' do
      address_attributes.each do |attribute,value|
        fill_in attribute.to_s.humanize, with: value
      end
    end
    checkout_continue
    expect_tab(:delivery)
  end

  def fill_delivery_step
    choose Delivery.first.name
    checkout_continue
    expect_tab(:payment)
  end

  def fill_payment_step
    within '.tab-pane.active' do
      fill_in 'Number', with: credit_card_attributes[:number]
      fill_in 'Code', with: credit_card_attributes[:code]
    end
    checkout_continue
    expect_tab(:confirm)
  end

  def fill_confirm_step
    expect(page).to have_content I18n.t('carts.checkout_confirm.ship_to_billing')
    expect(page).to have_content address_attributes[:firstname]
    expect(page).to have_content address_attributes[:phone]
    expect(page).to have_content Delivery.first.name
    click_on I18n.t('carts.checkout_confirm.btn_text.comfirm')
    expect_tab(:complete)
  end

  def fill_complete_step
    click_on I18n.t('carts.checkout_confirm.btn_text.complited')
    expect(page.current_path).to eq root_path
  end

  def checkout_continue
    click_on I18n.t('carts.checkout_continue_btn.text')
  end

  def expect_tab(tab)
    sleep 1
    expect(find('.nav-tabs .active')).to have_content I18n.t("carts.checkout.tab-#{tab}")
  end
end
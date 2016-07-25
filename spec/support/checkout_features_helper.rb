module CheckoutFeaturesHelper
  def fill_address_step(attributes = {}, type='billing')
    within ".tab-pane.active .#{type}-address" do
      attributes.each do |attribute, value|
        fill_in attribute.to_s.humanize, with: value
      end
    end
  end

  def fill_delivery_step(delivery = Delivery.first.name)
    choose delivery
    checkout_continue
    expect_tab(:payment)
  end

  def fill_payment_step(attributes)
    within '.tab-pane.active' do
      fill_in 'Number', with: attributes[:number]
      fill_in 'Code', with: attributes[:code]
    end
  end

  def fill_confirm_step
    [I18n.t('carts.checkout_confirm.ship_to_billing'),
     address_attributes[:firstname],
     address_attributes[:phone],
     Delivery.first.name].each do |expectation|
      expect(page).to have_content expectation
    end
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
    expect(find('.nav-tabs .active'))
      .to have_content I18n.t("carts.checkout.tab-#{tab}")
  end
end

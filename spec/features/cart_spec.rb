require 'rails_helper'

feature 'Cart' do
  context 'empty' do
    before { visit cart_path }
    scenario 'see message empty cart' do
      expect(page).to have_content I18n.t('carts.cart_content.empty')
    end
  end

  context 'with items' do
    let(:user) { create(:user) }
    let(:book) { create(:book) }

    context 'unregistered user' do
      scenario 'click on make order' do
        visit_cart_with(book)
        click_on I18n.t('carts.cart_content.make-order')
        expect(page).to have_content I18n.t('devise.failure.unauthenticated')
      end
    end

    context 'registered user' do
      scenario 'click on make order', js: true do
        sign_in(user)
        visit_cart_with(book)
        click_on I18n.t('carts.cart_content.make-order')
        expect(page).to have_css 'h1', text: 'Checkout'
      end
    end

    scenario 'delete item', js: true do
      visit_cart_with(book)
      find('.orders_item').find('[data-method=delete]').click
      accept_confirm do
        expect(page).to have_content I18n.t('carts.cart_content.empty')
      end
    end

    scenario 'update item count', js: true, fix: true do
      visit_cart_with(book)
      within '.orders_item' do
        fill_in 'orders_item[count]', with: 2
        # expect {find('[type=submit').click}.to change {find('.total').text}
        value = find('.total').text
        find('[type=submit]').click
        sleep 1
        expect(value).not_to eq find('.total').text
      end
    end

    context 'coupon' do
      before { visit_cart_with(book) }
      let(:coupon) { create(:coupon) }

      scenario 'add broken coupon' do
        fill_in 'coupon[name]', with: 'sale'
        find('.coupon [name=button]').click
        expect(page).to have_content I18n.t('coupons.apply.invalid_coupon')
      end

      scenario 'add valid coupon' do
        fill_in 'coupon[name]', with: coupon.name
        find('.coupon [name=button]').click
        expect(page).to have_content I18n.t('coupons.form.discount',
                                            discount: coupon.discount)
      end
    end
  end
end

module FeaturesHelper
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Sign in'
  end

  def add_book_to_cart(book)
    visit(book_path(book))
    click_add_to_cart
  end

  def click_add_to_cart
    within '#new_orders_item' do
      find('[type=submit]').click
    end
  end

  def visit_cart_with(book)
    add_book_to_cart(book)
    sleep 0.1
    visit cart_path
  end
end
require 'rails_helper'

feature 'Home page' do
  before do
    @books = [create(:ordered_book), create(:ordered_book)]
    visit root_path
  end

  scenario 'visit' do
    expect(page).to have_title 'Bookstore'
    expect(page).to have_css 'h1', text: 'Welcome to Bookstore!'
  end

  scenario 'containes popular books' do
    expect(page).to have_content @books[0].title
  end

  scenario 'can switch popular book', js: true do
    find('[data-slide=next]').click
    expect(page).to have_content @books[1].title
  end

  scenario 'can add book to the cart', js: true do
    click_add_to_cart
    expect(page).to have_css '.cart-link', text: 'Cart(1)'
  end
end

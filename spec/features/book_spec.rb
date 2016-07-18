require 'rails_helper'

feature 'Book' do
  let(:book) { create(:book) }
  let(:ordered_book) { create(:ordered_book) }
  before do
    visit book_path(book)
  end
  scenario 'can see book title, cover, description' do
    expect(page).to have_css 'h1', text: book.title
    expect(page).to have_css 'img'
    expect(page).to have_css '.description', text: book.description
  end
  scenario 'can see breadcrumbs' do
    expect(page).to have_css '.breadcrumb'
    expect(page).to have_css '.breadcrumb li', count: 2
  end
  context "book does't at the cart" do
    scenario 'can add book to the cart', js: true do
      click_add_to_cart
      expect(page).to have_css '.cart-link', text: 'Cart(1)'
    end
  end
  context 'book at the cart' do
    scenario 'can go to the cart', js: true do
      click_add_to_cart
      expect(page).to have_css('.cart-btn-container a.to-cart')
    end
  end
  context 'Reviews' do
    context "book hasn't reviews" do
      scenario 'can see message', js: true do
        expect(page).to have_content I18n.t('books.reviews.empty')
      end
    end
    let(:review) { create(:review, reviewable: book, status: :proved) }
    context 'book has reviews' do
      scenario 'can see reviews' do
        create(:review, reviewable: book, status: :proved)
        visit book_path(book)
        expect(page).to have_content book.reviews.first.text
      end
    end
  end
  context 'registred user' do
    let(:user) { create(:user) }
    scenario 'add review', js: true do
      sign_in(user)
      visit book_path(book)
      within '.new-review' do
        fill_in 'Text', with: FFaker::Lorem.paragraph
        find('#review_rating_3').click
        click_on 'Add review'
      end
      expect(page).to have_content I18n.t('books.success_review.message')
    end
  end
  context 'unregistred user' do
    scenario 'propose register to leave review' do
      expect(page).to have_content I18n.t('books.reviews.log_to_review')
    end
  end
end

require 'rails_helper'

feature 'Category' do
  let(:category) {create(:category)}
  before do
    create_list(:book, 30, category:category)
    visit category_path(category)
  end

  scenario 'contains first nine books' do
    expect(page).to have_content(category.books.last.title)
    expect(page).not_to have_content(category.books.first.title)
  end

  scenario 'can navigate by pages' do
    find('.pagination').find('.last a').click
    expect(page).not_to have_content(category.books.last.title)
    expect(page).to have_content(category.books.first.title)
  end
end
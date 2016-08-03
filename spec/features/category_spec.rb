require 'rails_helper'

feature 'Category' do
  let(:category) { create(:category) }
  before do
    create_list(:book, 30, category: category)
  end

  context 'category page' do
    before { visit category_path(category) }
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

  context 'shop page' do
    before { visit categories_path }
    scenario 'can see categories' do
      expect(page).to have_content(category.name)
    end
    scenario 'can link to category' do
      click_on(category.name)
      expect(page.current_path).to eq category_path(category)
    end
    scenario 'see books' do
      expect(page).to have_content(category.books.first.title)
    end
  end
end

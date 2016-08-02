class CategoriesController < ApplicationController
  def index
    @books = Book.all.page params[:page]
  end

  def show
    @category = Category.find(params[:id])
    @books = @category.books.page params[:page]
    add_breadcrumb @category.name, category_path(@category)
  end

  def set_breadcrumbs
    add_breadcrumb t('menu.home'), root_path
    add_breadcrumb t('menu.shop'), categories_path
  end
end

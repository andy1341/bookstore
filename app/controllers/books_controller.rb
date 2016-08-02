class BooksController < ApplicationController
  prepend_before_action :set_book

  def show
    @orders_item = current_order.orders_items.new
    add_breadcrumb @book.title, book_path(@book)
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def set_breadcrumbs
    add_breadcrumb t('menu.home'), root_path
    add_breadcrumb t('menu.shop'), categories_path
    add_breadcrumb @book.category.name, category_path(@book.category)
  end
end

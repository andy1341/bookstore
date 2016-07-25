class BooksController < ApplicationController
  prepend_before_action :set_book

  def show
    @orders_item = current_order.orders_items.new
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def set_breadcrumbs
    add_breadcrumb 'Home', root_path
    add_breadcrumb @book.category.name, category_path(@book.category)
  end
end

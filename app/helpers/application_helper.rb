module ApplicationHelper
  def categories
    @categories = Category.joins(:books).where('books.category_id is not null').distinct
  end
end

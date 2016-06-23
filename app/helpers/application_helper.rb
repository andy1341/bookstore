module ApplicationHelper
  def categories
    @categories = Category.joins(:books).where('books.category_id is not null').distinct
  end
  def icon(name)
    tag('span',class:"glyphicon glyphicon-#{name}")
  end
end

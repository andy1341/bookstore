module ApplicationHelper
  def categories
    @categories = Category.with_books
  end

  def icon(name)
    tag('span', class: "glyphicon glyphicon-#{name}")
  end
end

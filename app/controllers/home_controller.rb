class HomeController < ApplicationController
  def index
    @popular_books = Book.popular_books
  end
end

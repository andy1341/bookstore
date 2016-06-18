class HomeController < ApplicationController
  def index
    @popular_books = Book.all
  end
end

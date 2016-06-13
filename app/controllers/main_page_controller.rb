class MainPageController < ApplicationController
  def index
    @popular_books = Book.all
  end
end

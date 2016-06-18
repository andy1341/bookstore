class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :short_description, :description, :author_id, :category_id, :price, :image)
    end
end

class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @books = @category.books.page params[:page]
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name)
    end
end

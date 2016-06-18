class AuthorsController < ApplicationController
  def show
    @author = Author.find(params[:id])
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def author_params
      params.require(:author).permit(:firstname, :lastname, :description)
    end
end

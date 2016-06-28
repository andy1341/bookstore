class ReviewsController < ApplicationController
  before_action :set_review

  def create
    @review.update(review_params)
  end

  private

  def review_params
    params.require(:review).permit(:user_id,:text,:reviewable_type, :reviewable_id, :rating)
  end

  def set_review
    @review = Review.find_by_id(params[:id]) || Review.new
  end
end

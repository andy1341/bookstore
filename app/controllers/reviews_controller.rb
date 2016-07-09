class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @review = Review.create(review_params)
  end

  private

  def review_params
    params.require(:review).permit(:user_id,:text,:reviewable_type, :reviewable_id, :rating)
  end
end

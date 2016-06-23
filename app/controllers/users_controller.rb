class UsersController < ApplicationController
  before_action :authenticate_user!, :set_user

  def show
  end

  private

  def set_user
    @user = current_user
  end
end

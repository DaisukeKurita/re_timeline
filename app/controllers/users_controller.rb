class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    redirect_to user_path(current_user.id) unless @user == current_user
  end
end

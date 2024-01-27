class UsersController < ApplicationController

  def index
    @users = User.includes(:posts).all
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
  end

  def sign_out_user
    sign_out(current_user)
    redirect_to root_path, notice: 'Signed out successfully'
  end
end

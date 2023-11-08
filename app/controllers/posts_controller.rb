class PostsController < ApplicationController
  # GET /posts or /posts.json
  def index
    @user = User.find_by(id: params[:user_id])

    if @user
      @posts = @user.posts.page(params[:page]).per(10)
    else
      flash[:alert] = "User not found."
      redirect_to root_path
    end
  end

  # GET /posts/1 or /posts/1.json
  def show; end
end

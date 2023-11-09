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
  def show
    @post = Post.find(params[:id])
    @posts = @post.author.posts
    @post_index = @post.author.posts.order(created_at: :desc).pluck(:id).index(@post.id) + 1
  end
end

class PostsController < ApplicationController
  # GET /posts or /posts.json
  def index
    @user = User.find_by(id: params[:user_id])
    @posts = Post.where(author_id: @user.id)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
    @index = params[:index]
    @post_index = @post.author.posts.order(created_at: :desc).pluck(:id).index(@post.id) + 1
  end
end

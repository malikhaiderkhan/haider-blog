class PostsController < ApplicationController
  # GET /posts or /posts.json
  def index
    @user = User.find_by(id: params[:user_id])
    @posts = Post.where(author_id: @user.id)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
    @user = @post.author
    @index = params[:index]
    @post_index = @user.posts.order(created_at: :desc).pluck(:id).index(@post.id) + 1
    @comment = Comment.new
    @comments = @post.comments
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to user_post_path(current_user, @post), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end

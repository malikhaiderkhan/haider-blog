class LikesController < ApplicationController
    def create
      @post = Post.find(params[:post_id])
      @like = current_user.likes.build(post: @post)
  
      if @like.save
        @post.increment!(:likes_counter)
        redirect_to user_post_path(@user, @post), notice: 'Post was successfully liked.'
      else
        render 'posts/show'
      end
    end
  end
class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    redirect_to post_path(@post)
  end

  def index
    @user=User.find(params[:user_id])
  	@comments = @user.comments
  end

  def destroy
    Comment.find(params[:id]).destroy
    flash[:success]="Comment destroyed"
    redirect_to post_path(@post)
  end
end

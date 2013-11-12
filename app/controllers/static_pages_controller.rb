class StaticPagesController < ApplicationController
  def home
  	 @posts=Post.all
  	 @posts=@posts.take(5)
  end
end

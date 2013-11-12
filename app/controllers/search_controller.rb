class SearchController < ApplicationController
	def index
		 @tags = Tag.search(params[:q]).paginate(page: params[:page],:per_page => 10) if params[:theme] == 'Tag'
		 @posts = Post.paginate(page: params[:page],:per_page => 10).search(params[:q])	if params[:theme] == 'Post content'
		 @users = User.paginate(page: params[:page],:per_page => 10).search(params[:q])	if params[:theme] == 'User name'
	end
end

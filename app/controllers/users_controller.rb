class UsersController < ApplicationController
  before_filter :signed_in_user,	only: [:edit, :update, :destroy]
  before_filter :correct_user,		only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def show
  	@user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page],:per_page => 5)
  end

  def index
    @users = User.paginate(page: params[:page],:per_page => 10).search(params[:q])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
  	  sign_in @user
  	  flash[:success] = "Welcome to the Sample App!"
  	  redirect_to @user
  	else
  	  render 'new'
  	end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success]="User destroyed"
    redirect_to users_url
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to (root_path) unless current_user.admin?
    end
end
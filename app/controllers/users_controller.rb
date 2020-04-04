class UsersController < ApplicationController
  before_action :find_user_by_id, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user_or_admin, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Hi #{@user.username}! Welcome to Seppo's Blog"
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:danger] = "User and all articles have been deleted"
    redirect_to users_path
  end

  private
  def find_user_by_id
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_admin
    if !logged_in? || !is_admin? # both variables available because of setting these in logged_in? or prior before actions
      flash[:danger] = "You need to be admin"
      redirect_to root_path
    end
  end

  def require_same_user_or_admin
    if !logged_in? || (current_user != @user && !is_admin?) # both variables available because of setting these in logged_in? or prior before actions
      flash[:danger] = "You can only maintain your own profile"
      redirect_to root_path
    end
  end
end

class UsersController < ApplicationController
  before_action :find_user_by_id, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

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
      flash[:success] = "Welcome to Seppo Blog #{@user.username}"
      puts "redirect to index"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    puts @user
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def find_user_by_id
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if !logged_in? || current_user != @user  # both variables available because of setting these in logged_in? or prior before actions
      flash[:danger] = "You can only maintain your own profile"
      redirect_to root_path
    end
  end
end

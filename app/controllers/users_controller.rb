class UsersController < ApplicationController
  before_action :find_user_by_id, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Seppo Blog #{@user.username}"
      redirect_to articles_path
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
      redirect_to articles_path # for now...
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
end

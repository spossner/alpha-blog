class SessionsController < ApplicationController
  # show login form
  def new

  end

  # handle login post create session
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      session[:username] = user.username
      flash[:success] = "Login successfully"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Login credentials are wrong"
      render :new
    end
  end

  # destroy session when logging out
  def destroy
    reset_session
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end
end
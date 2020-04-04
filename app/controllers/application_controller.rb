class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?, :is_admin?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def is_admin?
    current_user.admin?
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in"
      redirect_to root_path
    end
  end
end

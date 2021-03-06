class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user	

  def current_user
    User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def log_user_in user
    session[:session_token] = user.session_token
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end

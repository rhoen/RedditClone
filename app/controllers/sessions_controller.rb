class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    username, password = user_params[:username], user_params[:password]
    @user = User.find_by_credentials(username, password)

    if @user
      @user.reset_session_token!
      log_user_in @user
      redirect_to user_url @user
    else
      flash.now[:errors] = ["Incorrect username/password combination"]
      @user = User.new(user_params)
      render :new
    end
  end

  def destroy

  end

end

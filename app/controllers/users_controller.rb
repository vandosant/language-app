class UsersController < ApplicationController
  def register
    @user = User.new
  end

  def create
    user = User.new
    user.email = params[:user][:email]
    user.password = params[:user][:password]
    if user.save
      log_in(user)
      redirect_to "/profile/#{user.id}", :notice => "welcome, #{user.email}"
    else
      @user = user
      render :register
    end
  end

  def login
  end

  def signin
    user = User.find_by_email(params[:email])
    if user.authenticate(params[:password])
      log_in(user)
      redirect_to "/profile/#{user.id}", :notice => 'you have successfully logged in'
    else
      render :login
    end
  end

  def logout
    session.clear
    redirect_to '/', :notice => 'you have successfully logged out'
  end
  private

  def log_in(user)
    session[:id] = user.id
  end
end
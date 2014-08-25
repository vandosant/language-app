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
      UserMailer.new_registration(user).deliver
      redirect_to "/profile/#{user.id}", :notice => ["welcome, #{user.email}"]
    else
      @user = user
      render :register
    end
  end

  private

  def log_in(user)
    session[:id] = user.id
  end
end
class UsersController < ApplicationController
  def register
  end

  def new
    user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password])
    if user.save
      log_in(user)
      redirect_to "/profile/#{user.id}"
    else
      render :new
    end
  end

  def login
  end

  def signin
    user = User.find_by_email(params[:email])
    if user.try(:authenticate, params[:password])
      log_in(user)
      redirect_to "/profile/#{user.id}", :notice => 'you have successfully logged in'
    else
      flash[:alert] = 'error: invalid password'
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
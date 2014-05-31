class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by_email(params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      log_in(user)
      redirect_to "/profile/#{user.id}", :notice => ["welcome, #{user.email}", 'you have successfully logged in']
    else
      @user = User.new
      flash[:alert] = ['invalid email or password']
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to '/', :notice => ['you have successfully logged out']
  end
  private

  def log_in(user)
    session[:id] = user.id
  end
end

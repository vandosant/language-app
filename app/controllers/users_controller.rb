class UsersController < ApplicationController
  def register
  end

  def new
    user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password])
    if user.save
      session[:id] = user.id
      redirect_to "/profile/#{user.id}"
    else
      render :new
    end
  end

  def login
  end
end
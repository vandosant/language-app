class UsersController < ApplicationController
  def register
  end

  def new
    user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password])
    user.save

    redirect_to "/profile/#{user.id}"
  end

  def login
  end
end
class LanguagesController < ApplicationController
  def index
    if session[:id]
      @user = User.find(session[:id])
    else
      redirect_to '/', notice: ["Access denied"]
    end
  end
end
class LanguagesController < ApplicationController
  def index
    @user = User.find(params[:id]) if params[:id]
  end
end
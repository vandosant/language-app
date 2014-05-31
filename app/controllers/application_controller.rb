class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def logged_in?
    true if session[:id]
  end

  helper_method :logged_in?
end

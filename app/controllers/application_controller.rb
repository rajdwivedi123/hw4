class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    if session[:user_id] && User.exists?(session[:user_id])
      @current_user = User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def require_login
    unless @current_user
      redirect_to "/login", alert: "You must be logged in to access this page."
    end
  end
end

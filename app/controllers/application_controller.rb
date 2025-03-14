class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_login
    if @current_user.nil?
      redirect_to "/login", alert: "You must be logged in to access this page."
    end
  end
end

class PlacesController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    if @current_user
      @places = Place.where("user_id = ?", @current_user["id"])  # Basic SQL-style query
    else
      redirect_to "/login"
    end
  end

  def new
  end

  def create
    @place = Place.new
    @place["name"] = params["name"]
    @place["user_id"] = @current_user["id"]
    @place.save
    redirect_to "/places"
  end
end

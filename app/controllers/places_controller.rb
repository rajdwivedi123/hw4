class PlacesController < ApplicationController
  before_action :require_login

  def index
    if @current_user
      @places = Place.where(user_id: @current_user.id)
    else
      @places = []
    end
  end

  def show
    @place = Place.find_by(id: params["id"], user_id: @current_user&.id)

    if @place.nil?
      redirect_to "/places", alert: "You do not have permission to view this place."
    else
      @entries = Entry.where(place_id: @place.id)
    end
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    @place.user_id = @current_user.id  # Associate with the logged-in user

    if @place.save
      redirect_to @place, notice: 'Place was successfully created.'
    else
      render :new
    end
  end

  private

  def place_params
    params.require(:place).permit(:name, :address, :description)  # Adjust attributes to match your model
  end
end

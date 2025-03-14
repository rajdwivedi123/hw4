class PlacesController < ApplicationController
  before_action :require_login

  class PlacesController < ApplicationController
    before_action :require_login
  
    def index
      @places = @current_user ? Place.where(user_id: @current_user.id) : []  # ✅ Prevents nil errors
    end
  end
  

  def index
    if @current_user
      @places = Place.where(user_id: @current_user.id)
    else
      @places = []  # ✅ Prevents nil errors
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
end

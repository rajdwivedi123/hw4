class EntriesController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def new
    @place = Place.find_by(id: params["place_id"], user_id: @current_user.id)
    redirect_to "/places", alert: "You do not have permission to add an entry here." if @place.nil?
  end

  def create
    @place = Place.find_by(id: params["place_id"], user_id: @current_user.id)

    if @place.nil?
      redirect_to "/places", alert: "You cannot add an entry to this place."
    else
      @entry = Entry.new
      @entry["title"] = params["title"]
      @entry["description"] = params["description"]
      @entry["occurred_on"] = params["occurred_on"]
      @entry["place_id"] = @place["id"]
      @entry["user_id"] = @current_user.id
      
      if params[:image]
        @entry.image.attach(params[:image])
      end

      if @entry.save
        redirect_to "/places/#{@place["id"]}", notice: "Entry added successfully!"
      else
        render "new"
      end
    end
  end
end

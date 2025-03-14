class EntriesController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def new
    @place = Place.find_by("id = ? AND user_id = ?", params["place_id"], @current_user["id"])
    redirect_to "/places" if @place.nil?
  end

  def create
    @place = Place.find_by("id = ? AND user_id = ?", params["place_id"], @current_user["id"])

    if @place
      @entry = Entry.new
      @entry["title"] = params["title"]
      @entry["description"] = params["description"]
      @entry["occurred_on"] = params["occurred_on"]
      @entry["place_id"] = @place["id"]
      @entry["user_id"] = @current_user["id"]
      @entry.save
      redirect_to "/places/#{@place["id"]}"
    else
      redirect_to "/places"
    end
  end
end

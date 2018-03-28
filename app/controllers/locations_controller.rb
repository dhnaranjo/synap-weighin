class LocationsController < ApplicationController
  def create
    @location = Location.create(location_params)
    redirect_to new_checkin_path
  end

  def index
    @locations = Location.all
  end

  def show
    @location = Location.find(params[:id])
  end

  private
  def location_params
    params.required(:location).permit([:name])
  end
end

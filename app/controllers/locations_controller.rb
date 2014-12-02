class LocationsController < ApplicationController
  def create
    location_data = Geocoder.search(params[:location][:zip_code]).first
    @location = Location.find_or_create_by(zip_code: location_data.postal_code)
    session[:location_id] = @location.id
  end
end

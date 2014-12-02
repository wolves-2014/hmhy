module LocationsHelper
  def location_data
    # To avoid 0/0 lat/long from geocoding 127.0.0.1
    if Rails.env.development?
      Location.default_development_location
    else
      request.location
    end
end

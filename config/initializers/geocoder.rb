Geocoder.configure ({
  lookup: :bing,
  api_key: ENV['BING_GEOCODE_ID'],
  cache: Rails.cache
})



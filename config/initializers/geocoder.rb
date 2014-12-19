Geocoder.configure ({
  lookup: :bing,
  timeout: 15,
  api_key: ENV['BING_GEOCODE_ID'],
  cache: Rails.cache
})



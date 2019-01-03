class Forecast

  attr_reader :location

  def initialize(location)
    @location = location
  end

  def hourly
    forecast[:hourly][:data][0..7]
  end

  def daily
    forecast[:daily][:data][0..4]
  end

  def current
    forecast[:currently]
  end

  def city
    city = google_geocode_service.location_data.find do |attribute|
      attribute[:types].include?("locality")
    end
    city[:long_name]
  end

  def state
    state = google_geocode_service.location_data.find do |attribute|
      attribute[:types].include?("administrative_area_level_1")
    end
    state[:short_name]
  end

  def country
    country = google_geocode_service.location_data.find do |attribute|
      attribute[:types].include?("country")
    end
    country[:short_name]
  end

private

  def google_geocode_service
    GoogleGeocodeService.new(location)
  end

  def latitude
    google_geocode_service.coordinates[:lat]
  end

  def longitude
    google_geocode_service.coordinates[:lng]
  end

  def dark_sky_service
    DarkSkyService.new(latitude, longitude)
  end

  def forecast
    @forecast ||= dark_sky_service.forecast
  end

end
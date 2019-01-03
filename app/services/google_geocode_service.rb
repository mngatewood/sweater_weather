class GoogleGeocodeService

  attr_reader :latitude, :longitude

  def initialize(location)
    @location = location
  end

  def coordinates
    data = get_json(geocode_url)
    data[:results][0][:geometry][:location]
  end

  def location_data
    data = get_json(geocode_url)
    data[:results][0][:address_components]
  end

private

  attr_reader :location

  def location_parameter
    location.parameterize(separator: '+')
  end

  def geocode_url
    "maps/api/geocode/json?address=#{location_parameter}&key=#{ENV['GOOGLE_API_KEY']}"
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://maps.googleapis.com/")
  end

end

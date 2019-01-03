class DarkSkyService

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def forecast
    url = "forecast/#{ENV['DARK_SKY_API_KEY']}/#{latitude},#{longitude}"
    data = get_json(url)
  end

  private

  attr_reader :latitude, :longitude

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.darksky.net/")
  end

end
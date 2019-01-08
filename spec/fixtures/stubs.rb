module Stubs

  def geocode_all
    geocode_denver
    geocode_vegas
    geocode_phoenix
  end

  def forecast_all
    forecast_denver
    forecast_vegas
    forecast_phoenix
  end

  def geocode_denver
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=denver+co&key=#{ENV['GOOGLE_API_KEY']}").
      to_return(body: File.read("./spec/fixtures/geocode.json"))
  end

  def geocode_vegas
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=las+vegas+nv&key=#{ENV['GOOGLE_API_KEY']}").
      to_return(body: File.read("./spec/fixtures/geocode_vegas.json"))
  end

  def geocode_phoenix
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=phoenix+az&key=#{ENV['GOOGLE_API_KEY']}").
      to_return(body: File.read("./spec/fixtures/geocode_phoenix.json"))
  end

  def forecast_denver
    stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARK_SKY_API_KEY']}/39.7507834,-104.9964355").
      to_return(body: File.read("./spec/fixtures/forecast.json"))
  end

  def forecast_vegas
    stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARK_SKY_API_KEY']}/36.1699412,-115.1398296").
      to_return(body: File.read("./spec/fixtures/forecast_vegas.json"))
  end

  def forecast_phoenix
    stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARK_SKY_API_KEY']}/33.4483771,-112.0740373").
      to_return(body: File.read("./spec/fixtures/forecast_phoenix.json"))
  end

  def forecast_gifs
    stub_request(:get, "http://api.giphy.com/v1/gifs/search?api_key=#{ENV['GIPHY_API_KEY']}&q=Clear throughout the day.").
      to_return(body: File.read("./spec/fixtures/gif.json"))
  end

end

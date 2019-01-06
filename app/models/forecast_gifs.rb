class ForecastGifs

  attr_reader :location

  def initialize(location)
    @location = location
  end

  def daily_forecasts
    daily_forecast = []
    daily_weather_forecast.each do |day|
      gif = Gif.new(day[:summary], day[:time])
      forecast = { 
                   time: gif.time,
                   summary: gif.summary,
                   url: gif.url
                  }
      daily_forecast << forecast
    end
    return daily_forecast
  end

  def copyright
    Date.today.year.to_s
  end

private

  def daily_weather_forecast
    forecast = Forecast.new(location)
    daily_forecast = forecast.daily
  end


end
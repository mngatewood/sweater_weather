class GifsFacade

  def initialize(location)
    @location = location
  end

  def forecast
    Forecast.new(location)
  end

  def time
    
  end

  def daily_forecast

    forecast = Forecast.new(location)

  end

end
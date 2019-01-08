class Favorite < ApplicationRecord

  belongs_to :user

  def current_weather
    Forecast.new(location).current[:summary]
  end
  
end
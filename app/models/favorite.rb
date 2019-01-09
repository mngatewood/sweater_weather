class Favorite < ApplicationRecord

  scope :active, -> { where(active: true) }

  belongs_to :user

  def current_weather
    Forecast.new(location).current
  end
  
end
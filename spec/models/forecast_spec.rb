require 'rails_helper'
require './spec/fixtures/stubs'

describe Forecast, type: :model do
  include Stubs
  describe 'Methods' do
    
    before(:each) do
      geocode_denver
      forecast_denver
      @forecast = Forecast.new("Denver,CO")
    end

    it 'should return a city' do
      expect(@forecast.city).to eq("Denver")
    end
    it 'should return a state' do
      expect(@forecast.state).to eq("CO")
    end
    it 'should return a country' do
      expect(@forecast.country).to eq("US")
    end
    it 'should return a current forecast' do
      expect(@forecast.current[:time]).to eq(1546490583)
      expect(@forecast.current[:summary]).to eq("Clear")
      expect(@forecast.current[:temperature]).to eq(23)
    end
    it 'should return an hourly forecast' do
      expect(@forecast.hourly.count).to eq(8)
      expect(@forecast.hourly.first[:time]).to eq(1546488000)
      expect(@forecast.hourly.first[:summary]).to eq("Clear")
      expect(@forecast.hourly.first[:temperature]).to eq(24.33)
    end
    it 'should return a daily forecast' do
      expect(@forecast.daily.count).to eq(5)
      expect(@forecast.daily.first[:time]).to eq(1546412400)
      expect(@forecast.daily.first[:summary]).to eq("Clear throughout the day.")
      expect(@forecast.daily.first[:temperatureHigh]).to eq(41.69)
    end

  end
end
require 'rails_helper'
require './spec/fixtures/stubs'

describe ForecastGifs, type: :model do
  include Stubs
  describe 'Methods' do

    before(:each) do
      geocode_denver
      forecast_denver
      @forecast_gifs = ForecastGifs.new("Denver,CO")
    end

    it 'should return five daily forecasts' do
      VCR.use_cassette('giphy_request', record: :once) do
        expect(@forecast_gifs.daily_forecasts.count).to eq(5)
        expect(@forecast_gifs.daily_forecasts.first[:time]).to eq(1546412400)
        expect(@forecast_gifs.daily_forecasts.first[:summary]).to eq("Clear throughout the day.")
        expect(@forecast_gifs.daily_forecasts.first).to have_key(:url)
        expect(@forecast_gifs.daily_forecasts.last[:time]).to eq(1546758000)
        expect(@forecast_gifs.daily_forecasts.last[:summary]).to eq("Foggy starting in the evening.")
        expect(@forecast_gifs.daily_forecasts.last).to have_key(:url)
      end
    end

    it 'should return a copyright year' do
      VCR.use_cassette('giphy_request', record: :once) do
        expect(@forecast_gifs.copyright).to eq('2019')
      end
    end
  end
end
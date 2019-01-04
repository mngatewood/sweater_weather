require 'rails_helper'

describe ForecastGifs, type: :model do
  describe 'Methods' do
    before(:each) do
      stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=denver+co&key=#{ENV['GOOGLE_API_KEY']}").
        to_return(body: File.read("./spec/fixtures/geocode.json"))
      stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARK_SKY_API_KEY']}/39.7507834,-104.9964355").
        to_return(body: File.read("./spec/fixtures/forecast.json"))
      @forecast_gifs = ForecastGifs.new("Denver,CO")
    end

    it 'should return five daily forecasts' do
      VCR.use_cassette('giphy_request', record: :all) do
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
      VCR.use_cassette('giphy_request', record: :all) do
        expect(@forecast_gifs.copyright).to eq('2019')
      end
    end
  end
end
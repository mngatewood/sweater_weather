require 'rails_helper'
require './spec/fixtures/stubs'

describe 'gifs API' do
  include Stubs

  before(:each) do
    geocode_denver
    forecast_denver
    VCR.use_cassette('giphy_request', record: :once) do
      get "/api/v1/gifs?location=denver,co"
    end
    @data = JSON.parse(response.body, symbolize_names: true)
    @daily_forecasts = @data[:data][:attributes][:daily_forecasts]
  end

  it 'should return five daily forecasts' do
    expect(@daily_forecasts.count).to eq(5)
    expect(@daily_forecasts.first[:time]).to eq(1546412400)
    expect(@daily_forecasts.first[:summary]).to eq("Clear throughout the day.")
    expect(@daily_forecasts.first).to have_key(:url)
    expect(@daily_forecasts.last[:time]).to eq(1546758000)
    expect(@daily_forecasts.last[:summary]).to eq("Foggy starting in the evening.")
    expect(@daily_forecasts.last).to have_key(:url)
  end

  it 'should return a copyright year' do
    expect(@data[:data][:attributes][:copyright]).to eq('2019')
  end

end
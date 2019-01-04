require 'rails_helper'

describe 'gifs API' do

  before(:each) do
    # stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=denver+co&key=#{ENV['GOOGLE_API_KEY']}").
    #   to_return(body: File.read("./spec/fixtures/geocode.json"))
    # stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARK_SKY_API_KEY']}/39.7507834,-104.9964355").
    #   to_return(body: File.read("./spec/fixtures/forecast.json"))  
    get "/api/v1/gifs?location=denver,co"
    @data = JSON.parse(response.body, symbolize_names: true)
  end

  it 'should return five daily forecasts' do
    expect(@data[:data][:daily_forecasts].count).to eq(5)
    expect(@data[:data][:daily_forecasts].first[:time]).to eq("   ")
    expect(@data[:data][:daily_forecasts].first[:summary]).to eq("   ")
    expect(@data[:data][:daily_forecasts].first).to have_key(:url)
    expect(@data[:data][:daily_forecasts].last[:time]).to eq("   ")
    expect(@data[:data][:daily_forecasts].last[:summary]).to eq("   ")
    expect(@data[:data][:daily_forecasts].last).to have_key(:url)
  end

  it 'should return a copyright year' do
    expect(@data[:data][:copyright]).to eq('2019')
  end

end
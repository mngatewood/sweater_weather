require "rails_helper"

describe "Forecast API" do

  before(:each) do
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=denver+co&key=#{ENV['GOOGLE_API_KEY']}").
      to_return(body: File.read("./spec/fixtures/geocode.json"))
    stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARK_SKY_API_KEY']}/39.7507834,-104.9964355").
      to_return(body: File.read("./spec/fixtures/forecast.json"))
    get "/api/v1/forecast?location=denver,co"
    @data = JSON.parse(response.body, symbolize_names: true)
  end

  it "returns an array of 8 hourly forecasts" do
    hourly_forecasts = @data[:data][:attributes][:hourly]

    expect(response).to be_successful
    expect(hourly_forecasts).to be_an(Array)
    expect(hourly_forecasts.count).to eq(8)
  end

  it "starts hourly forecasts with the current hour" do
    def unix_to_hour(unix)
      Time.strptime(unix.to_s,'%s').hour
    end
    hourly_forecasts = @data[:data][:attributes][:hourly]

    expect(unix_to_hour(hourly_forecasts.first[:time])).to eq(21)
    expect(unix_to_hour(hourly_forecasts.last[:time])).to eq(4)
  end

end
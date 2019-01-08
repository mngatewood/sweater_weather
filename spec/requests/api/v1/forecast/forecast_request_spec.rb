require "rails_helper"
require './spec/fixtures/stubs'

describe "Forecast API" do
  include Stubs

  before(:each) do
    geocode_denver
    forecast_denver

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
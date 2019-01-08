require 'rails_helper'
require './spec/fixtures/stubs'

describe 'Favorites API' do
  include Stubs
  describe 'List favorite locations (GET)' do
    describe 'with a valid api key' do

      before(:each) do
        geocode_all
        forecast_all

        @user = create(:user)
        @location_1 = @user.favorites.create(location: "Denver, CO")
        @location_2 = @user.favorites.create(location: "Las Vegas, NV")
        @location_3 = @user.favorites.create(location: "Phoenix, AZ")
        params = {
                    "api_key": @user.api_key
                  }
        get "/api/v1/favorites", params: params
        @data = JSON.parse(response.body, symbolize_names: true)
      end

      it 'returns all favorites for the provided api key' do
        expect(response).to be_successful
        expect(@data[:data].count).to eq(3)
        expect(@data[:data][0][:attributes][:location]).to eq("Denver, CO")
        expect(@data[:data][0][:attributes][:current_weather][:summary]).to eq("Clear")
        expect(@data[:data][0][:attributes][:current_weather][:temperature]).to eq(23)
        expect(@data[:data][1][:attributes][:location]).to eq("Las Vegas, NV")
        expect(@data[:data][1][:attributes][:current_weather][:summary]).to eq("Partly Cloudy")
        expect(@data[:data][1][:attributes][:current_weather][:temperature]).to eq(61.11)
        expect(@data[:data][2][:attributes][:location]).to eq("Phoenix, AZ")
        expect(@data[:data][2][:attributes][:current_weather][:summary]).to eq("Clear")
        expect(@data[:data][2][:attributes][:current_weather][:temperature]).to eq(71.26)
      end
    end

    describe 'with an invalid api key' do

      before(:each) do
        @user = create(:user)
        @location_1 = @user.favorites.create(location: "Denver, CO")
        @location_2 = @user.favorites.create(location: "Las Vegas, NV")
        @location_3 = @user.favorites.create(location: "Phoenix, AZ")
        params = {
                    "api_key": "invalid"
                  }
        get "/api/v1/favorites", params: params
        @data = JSON.parse(response.body, symbolize_names: true)
      end

      it 'returns an error' do
        expect(response.status).to eq(401)
        expect(@data[:error]).to eq("Invalid credentials.")
      end
    end

    describe 'without an api key' do

      before(:each) do
        @user = create(:user)
        @location_1 = @user.favorites.create(location: "Denver, CO")
        @location_2 = @user.favorites.create(location: "Las Vegas, NV")
        @location_3 = @user.favorites.create(location: "Phoenix, AZ")
        params = { }
        get "/api/v1/favorites", params: params
        @data = JSON.parse(response.body, symbolize_names: true)
      end

      it 'returns an error' do
        expect(response.status).to eq(401)
        expect(@data[:error]).to eq("Invalid credentials.")
      end
    end
  end
end
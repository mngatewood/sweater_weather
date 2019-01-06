require 'rails_helper'

describe 'Favorites API' do
  describe 'List favorite locations (GET)' do
    describe 'with a valid api key' do

      before(:each) do
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
        expect(@data[:data][1][:attributes][:location]).to eq("Las Vegas, NV")
        expect(@data[:data][2][:attributes][:location]).to eq("Phoenix, AZ")
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
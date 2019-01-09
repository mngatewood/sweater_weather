require 'rails_helper'
require './spec/fixtures/stubs'

describe 'Favorites API' do
  include Stubs
  describe 'Delete a favorite location (DELETE)' do

    before(:each) do
      geocode_all
      forecast_all

      @user = create(:user)
      @favorite_1 = @user.favorites.create(location: "Denver, CO")
      @favorite_2 = @user.favorites.create(location: "Las Vegas, NV")
      @favorite_3 = @user.favorites.create(location: "Phoenix, AZ")
    end

    describe 'with a valid api key' do

      before(:each) do
        params = {
                    "id": @favorite_3.id,
                    "api_key": @user.api_key
                  }
        delete "/api/v1/favorites", params: params
        @data = JSON.parse(response.body, symbolize_names: true)
      end

      it 'deactivates a favorite' do
        expect(@user.favorites.active.count).to eq(2)
        expect(@user.favorites.active.find_by(location: @favorite_3.location)).to be_nil
      end

      it 'does not permanently destroy the favorite' do
        expect(@user.favorites.find_by(location: @favorite_3.location)).to eq(@favorite_3)
      end

      it 'returns the remaining active favorites' do
        expect(response).to be_successful
        expect(@data[:data].count).to eq(2)
        expect(@data[:data][0][:attributes][:location]).to eq("Denver, CO")
        expect(@data[:data][0][:attributes][:current_weather][:summary]).to eq("Clear")
        expect(@data[:data][0][:attributes][:current_weather][:temperature]).to eq(23)
        expect(@data[:data][1][:attributes][:location]).to eq("Las Vegas, NV")
        expect(@data[:data][1][:attributes][:current_weather][:summary]).to eq("Partly Cloudy")
        expect(@data[:data][1][:attributes][:current_weather][:temperature]).to eq(61.11)
      end
    end

    describe 'with an invalid api key' do

      before(:each) do
        params = {
                    "id": @favorite_3.id,
                    "api_key": "invalid"
                  }
        delete "/api/v1/favorites", params: params
        @data = JSON.parse(response.body, symbolize_names: true)
      end

      it 'does not delete a favorite' do
        expect(response).to_not be_successful
        expect(@user.favorites.active.count).to eq(3)
      end

      it 'returns an error' do
        expect(response.status).to eq(401)
        expect(@data[:error]).to eq("Invalid credentials.")
      end
    end

    describe 'without an api key' do

      before(:each) do
        params = {
                    "id": @favorite_3.id
                  }
        delete "/api/v1/favorites", params: params
        @data = JSON.parse(response.body, symbolize_names: true)
      end

      it 'does not delete a favorite' do
        expect(response).to_not be_successful
        expect(@user.favorites.active.count).to eq(3)
      end

      it 'returns an error' do
        expect(response.status).to eq(401)
        expect(@data[:error]).to eq("Missing required parameters.")
      end
    end

    describe 'with an invalid favorite id' do

      before(:each) do
        params = {
                    "id": "invalid",
                    "api_key": @user.api_key
                  }
        delete "/api/v1/favorites", params: params
        @data = JSON.parse(response.body, symbolize_names: true)
      end

      it 'does not delete a favorite' do
        expect(response).to_not be_successful
        expect(@user.favorites.active.count).to eq(3)
      end

      it 'returns an error' do
        expect(response.status).to eq(401)
        expect(@data[:error]).to eq("Invalid favorite id.")
      end
    end

    describe 'without a favorite id' do

      before(:each) do
        params = {
                    "api_key": @user.api_key
                  }
        delete "/api/v1/favorites", params: params
        @data = JSON.parse(response.body, symbolize_names: true)
      end

      it 'does not delete a favorite' do
        expect(response).to_not be_successful
        expect(@user.favorites.active.count).to eq(3)
      end

      it 'returns an error' do
        expect(response.status).to eq(401)
        expect(@data[:error]).to eq("Missing required parameters.")
      end
    end
  end
end
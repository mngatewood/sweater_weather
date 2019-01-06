require 'rails_helper'

describe 'Favorites API' do

  describe 'Add a favorite location (POST)' do

    describe 'with a valid api key' do

      before(:each) do
        @user = create(:user)
        params = {
                    "location": "Denver, CO",
                    "api_key": @user.api_key
                  }
        post "/api/v1/favorites", params: params
        @data = JSON.parse(response.body, symbolize_names: true)
      end

      it 'creates a favorite' do
        expect(response).to be_successful
        expect(@user.favorites.first.location).to eq("Denver, CO")
      end

      it 'returns the favorite' do
        expect(@data[:data][:id]).to eq(@user.favorites.first.id.to_s)
        expect(@data[:data][:attributes][:location]).to eq("Denver, CO")
      end
    end

    describe 'with an invalid api key' do

      before(:each) do
        @user = create(:user)
        params = {
                    "location": "Denver, CO",
                    "api_key": "invalid"
                  }
        post "/api/v1/favorites", params: params
        @data = JSON.parse(response.body, symbolize_names: true)
      end

      it 'does not create a favorite' do
        expect(@user.favorites).to eq([])
      end

      it 'returns an error' do
        expect(@data[:error]).to eq("Invalid credentials.")
      end
    end

    describe 'without an api key' do

      before(:each) do
        @user = create(:user)
        params = {
                    "location": "Denver, CO"
                  }
        post "/api/v1/favorites", params: params
        @data = JSON.parse(response.body, symbolize_names: true)
      end

      it 'does not create a favorite' do
        expect(response).to_not be_successful
        expect(@user.favorites).to eq([])
      end

      it 'returns an error' do
        expect(response.status).to eq(401)
        expect(@data[:error]).to eq("Missing required parameters.")
      end
    end

    describe 'without a location' do

      before(:each) do
        @user = create(:user)
        params = {
                    "api_key": @user.api_key
                  }
        post "/api/v1/favorites", params: params
        @data = JSON.parse(response.body, symbolize_names: true)
      end

      it 'does not create a favorite' do
        expect(response).to_not be_successful
        expect(@user.favorites).to eq([])
      end

      it 'returns an error' do
        expect(response.status).to eq(401)
        expect(@data[:error]).to eq("Missing required parameters.")
      end
    end
  end
end
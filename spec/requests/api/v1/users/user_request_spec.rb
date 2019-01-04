require 'rails_helper'

describe 'User API' do
  describe 'user creates an account' do

    before(:each) do
      params = {
                "email": "whatever@example.com",
                "password": "password",
                "password_confirmation": "password"
               }
      post '/api/v1/users', params: params
      @result = JSON.parse(response.body, symbolize_names: true)
    end

    it 'should create an account' do
      expect(User.count).to eq(1)
      expect(User.first.email).to eq("whatever@example.com")
      expect(User.first.api_key).to_not be_nil
    end

    it 'should return a status code and api key' do
      expect(response).to be_successful
      expect(@result[:data][:attributes][:status]).to eq(201)
      expect(@result[:data][:attributes]).to have_key(:api_key)
    end

  end
end
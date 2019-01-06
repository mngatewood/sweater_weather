require 'rails_helper'

describe 'Sessions API' do
  describe 'user logs in with valid credentials' do

    before(:each) do
      @user = create(:user)
      params = {
                "email": @user.email,
                "password": @user.password,
               }
      post '/api/v1/sessions', params: params
      @result = JSON.parse(response.body, symbolize_names: true)
    end

    it 'should create a user session' do
      expect(session[:user_id]).to eq(@user.id)
    end

    it 'should return a status code and api key' do
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(@result[:data][:attributes]).to have_key(:api_key)
    end
  end

  describe 'user logs in with invalid credentials' do

    before(:each) do
      @user = create(:user)
    end

    describe 'invalid user' do

      before(:each) do
        params = {
                  "email": "invalid@example.com",
                  "password": @user.password,
                  }
        post '/api/v1/sessions', params: params
        @result = JSON.parse(response.body, symbolize_names: true)
      end

      it 'should throw an error' do
        expect(response).to_not be_successful
        expect(session[:user_id]).to be_nil
        expect(response.status).to eq(401)
        expect(@result).to_not have_key(:data)
        expect(@result[:error]).to eq("Invalid credentials.")
      end
    end


    describe 'invalid password' do

      before(:each) do
        params = {
                  "email": @user.password,
                  "password": "invalid",
                  }
        post '/api/v1/sessions', params: params
        @result = JSON.parse(response.body, symbolize_names: true)
      end

      it 'should throw an error' do
        expect(response).to_not be_successful
        expect(session[:user_id]).to be_nil
        expect(response.status).to eq(401)
        expect(@result).to_not have_key(:data)
        expect(@result[:error]).to eq("Invalid credentials.")
      end
    end


  end
end
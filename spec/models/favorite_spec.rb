require 'rails_helper'
require './spec/fixtures/stubs'

describe Favorite, type: :model do
  include Stubs

  describe 'Relationships' do

    it { should belong_to :user }
    
  end

  describe 'Methods' do

    before(:each) do
      geocode_denver
      forecast_denver
    end

    it 'should return the current weather' do
      user = create(:user)
      favorite = user.favorites.create(location: "Denver, CO")

      expect(favorite.current_weather).to eq("Clear")
    end

  end

end
require 'rails_helper'

describe 'GoogleGeocodeService' do

  before(:each) do
    location = "Denver, CO"
    @service = GoogleGeocodeService.new(location)
  end

  it 'should return coordinates' do
    VCR.use_cassette('geocode_lookup', record: :once) do
      expect(@service.coordinates).to eq({lat: 39.7392358,
                                          lng: -104.990251})
    end
  end

  it 'should return location data (city, state, and country)' do
    VCR.use_cassette('geocode_lookup', record: :once) do
      expected = JSON.parse(File.read("./spec/fixtures/location_data.json"), symbolize_names: true)
      expect(@service.location_data).to eq(expected)
    end
  end

end
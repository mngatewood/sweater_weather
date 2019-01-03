require 'rails_helper'

describe 'GoogleGeocodeService' do

  it 'should return coordinates' do
    address = "1331 17th Street, Denver, CO 80202"
    service = GoogleGeocodeService.new(address)
    expect(service.coordinates).to eq({lat: 39.7507834,
                                       lng: -104.9964355})
  end

  it 'should return location data (city, state, and country)' do
    address = "1331 17th Street, Denver, CO 80202"
    service = GoogleGeocodeService.new(address)
    expected = JSON.parse(File.read("./spec/fixtures/location_data.json"), symbolize_names: true)
    expect(service.location_data).to eq(expected)
  end

end
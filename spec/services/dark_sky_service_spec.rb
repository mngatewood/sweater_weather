require 'rails_helper'

describe 'DarkSkyService' do
  it 'should return a forcast' do
    VCR.use_cassette('dark_sky_request', record: :all) do
      latitude = 39.7507834
      longitude = -104.9964355
      service = DarkSkyService.new(latitude, longitude)
      expected_keys =  [:latitude,
                        :longitude,
                        :timezone,
                        :currently,
                        :minutely,
                        :hourly,
                        :daily,
                        :flags,
                        :offset]
      expect(service.forecast.keys).to eq(expected_keys)
    end
  end
end
require 'rails_helper'

describe 'GiphyService' do
  it 'should return gif data' do
    VCR.use_cassette('giphy_request', record: :once) do
      summary = "Clear throughout the day."
      service = GiphyService.new(summary)

      expect(service.gif_fetch[:data]).to be_an(Array)
      expect(service.gif_fetch[:data].first).to have_key(:url)
      expect(service.gif_fetch[:data].last).to have_key(:url)
    end
  end
end
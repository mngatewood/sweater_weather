require 'rails_helper'

describe 'GiphyService' do
  it 'should return gif data' do
    VCR.use_cassette('giphy_request', record: :all) do
      summary = "Clear throughout the day."
      service = GiphyService.new(summary)

      expect(service).to ???
    end
  end
end
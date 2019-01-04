require 'rails_helper'

describe Gif, type: :model do

  before(:each) do
    stub_request(:get, "http://api.giphy.com/v1/gifs/search?api_key=#{ENV['GIPHY_API_KEY']}&q=Clear throughout the day.").
      to_return(body: File.read("./spec/fixtures/gif.json"))
    @gif = Gif.new("Clear throughout the day.", 1546585200)
  end

  it 'should return a URL' do
    expect(@gif.url).to be_a(String)
    expect(@gif.url).to start_with("http")
  end

  it 'should return summary and time' do
    expect(@gif.summary).to eq("Clear throughout the day.")
    expect(@gif.time).to eq(1546585200)
  end

end
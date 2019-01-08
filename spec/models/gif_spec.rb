require 'rails_helper'
require './spec/fixtures/stubs'

describe Gif, type: :model do
  include Stubs

  before(:each) do
    forecast_gifs

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
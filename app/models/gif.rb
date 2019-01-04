class Gif

  attr_reader :summary, :time

  def initialize(summary, time)
    @summary = summary
    @time = time
  end

  def data
    response = Faraday.get("http://api.giphy.com/v1/gifs/search?api_key=#{ENV['GIPHY_API_KEY']}&q=#{@query}")
    data = JSON.parse(response.body, symbolize_name: true)
  end

  def url
    data[:data].first[:url]
  end

end
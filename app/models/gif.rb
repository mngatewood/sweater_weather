class Gif

  attr_reader :summary, :time

  def initialize(summary, time)
    @summary = summary
    @time = time
  end

  def data
    url = "search?api_key=#{ENV['GIPHY_API_KEY']}&q=#{summary}"
    data = get_json(url)
  end

  def url
    data[:data].first[:url]
  end

private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "http://api.giphy.com/v1/gifs/")
  end

end
class GiphyService

  def initialize(summary)
    @summary = summary
  end

  def gif_fetch
    url = "search?api_key=#{ENV['GIPHY_API_KEY']}&q=#{summary}"
    data = get_json(url)
  end

private

  attr_reader :summary

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "http://api.giphy.com/v1/gifs/")
  end

end
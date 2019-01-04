class Gif

  attr_reader :summary, :time

  def initialize(summary, time)
    @summary = summary
    @time = time
  end

  def url
    data = giphy_service.gif_fetch
    data[:data].first[:url]
  end

private

  def giphy_service
    GiphyService.new(summary)
  end

end
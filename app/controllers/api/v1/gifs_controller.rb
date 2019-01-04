class Api::V1::GifsController < ApplicationController

  def show
    forecast = ForecastGifs.new(params[:location])
    render json: GifsSerializer.new(forecast)
  end

end

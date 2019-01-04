class Api::V1::GifsController < ApplicationController

  def show
    facade = GifsFacade.new(params[:location])
    render json: GifsSerializer.new(facade)
  end

end

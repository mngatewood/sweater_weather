class Api::V1::FavoritesController < ApplicationController

  def create
    user = User.find_by(api_key: params[:api_key])
    if user && params[:location] && params[:api_key]
      favorite = user.favorites.create(location: params[:location])
      render json: FavoritesSerializer.new(favorite, { params: { api_key: params[:api_key]} }), status: 200
    elsif params[:location] && params[:api_key] 
      render json: { :error => "Invalid credentials." }, status: 401
    else
      render json: { :error => "Missing required parameters." }, status: 401
    end
  end

end
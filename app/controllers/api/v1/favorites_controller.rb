class Api::V1::FavoritesController < ApplicationController

  def create
    if current_user && params[:location]
      favorite = current_user.favorites.create(location: params[:location])
      render json: FavoritesSerializer.new(favorite), status: 200
    elsif params[:location] && params[:api_key] 
      render json: { :error => "Invalid credentials." }, status: 401
    else
      render json: { :error => "Missing required parameters." }, status: 401
    end
  end

  def index
    if current_user
      render json: FavoritesSerializer.new(current_user.favorites.active), status: 200
    else
      render json: { :error => "Invalid credentials." }, status: 401
    end
  end

  def destroy
    favorite = Favorite.find_by(id: params[:id])
    if current_user && favorite
      favorite.update_attributes(active: false)
      render json: FavoritesSerializer.new(current_user.favorites.active), status: 200
    elsif favorite && params[:api_key] #invalid user
      render json: { :error => "Invalid credentials." }, status: 401
    elsif current_user && params[:id] #invalid favorite
      render json: { :error => "Invalid favorite id." }, status: 401
    else
      render json: { :error => "Missing required parameters." }, status: 401
    end
  end

end

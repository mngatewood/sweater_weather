class Api::V1::UsersController < ApplicationController
  
  def create
    api_key = SecureRandom.urlsafe_base64(16)
    user = User.new(user_params.merge(api_key: api_key))
    if user.save
      render json: UserSerializer.new(user), status: 201
    else
      render json: { :error => "Unable to create user." }, status: 422
    end
  end

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
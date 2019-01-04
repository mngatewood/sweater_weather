class Api::V1::UsersController < ApplicationController
  
  def create
    api_key = SecureRandom.urlsafe_base64(16)
    user = User.create(user_params.merge(api_key: api_key))
    render json: UserSerializer.new(user)
  end

  def user_params
    params.permit(:email, :password, :password_confirmation  )
  end
end
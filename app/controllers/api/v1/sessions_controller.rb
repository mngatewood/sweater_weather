class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: user_params[:email])
    if user && user.authenticate(user_params[:password])
      render json: UserSerializer.new(user), status: 200
    else
      render json: { :error => "Invalid credentials." }, status: 401
    end
  end

  def user_params
    params.permit(:email, :password)
  end

end

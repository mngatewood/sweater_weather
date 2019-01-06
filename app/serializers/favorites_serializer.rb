class FavoritesSerializer
  include FastJsonapi::ObjectSerializer

  attributes :user_id,
             :location

  attribute :api_key do |object, params|
    params[:api_key]
  end

end
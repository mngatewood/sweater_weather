class FavoritesSerializer
  include FastJsonapi::ObjectSerializer

  attributes :user_id,
             :location,
             :current_weather

end
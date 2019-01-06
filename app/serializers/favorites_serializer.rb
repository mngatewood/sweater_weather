class FavoritesSerializer
  include FastJsonapi::ObjectSerializer

  attributes :user_id,
             :location

end
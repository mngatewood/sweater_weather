class GifsSerializer
  include FastJsonapi::ObjectSerializer

  set_id :location

  attributes :daily_forecasts,
             :copyright
             
end
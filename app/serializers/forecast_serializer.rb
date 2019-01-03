class ForecastSerializer
  include FastJsonapi::ObjectSerializer

  set_id :location

  attributes :city,
             :state,
             :country,
             :current,
             :hourly,
             :daily
             
end
class ForecastSerializer
  include FastJsonapi::ObjectSerializer

  set_id :location

  attributes :city,
             :state,
             :country,
             :summary,
             :current,
             :hourly,
             :daily
             
end
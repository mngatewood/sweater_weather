class UserSerializer
  include FastJsonapi::ObjectSerializer

  attribute :status { 201 }
  
  attributes :api_key
             
end
FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "whatever#{n}@example.com" }
    password         { "password" }
    api_key          { "1324abcd" }
  end
end
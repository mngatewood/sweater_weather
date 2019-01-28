# README

Sweater Weather is a micro-service API that combines services from Dark Sky API, Google Geocoding API, and Giphy API. The server submits a location to Google Geocoding API, which returns latitude and longitude coordinates for the location.  These coordinates are then submitted to the Dark Sky API, which returns current and forecasted weather information for the location.  The current weather summary is also submitted to the Giphy API, which returns a random GIF related to the current weather.  A future feature will also provide a background photo for the selected location.

## Versions
Ruby 2.4.1,
Rails 5.2.2

* Database: Postgresql

## Gems
- ``ruby '2.4.1'``
- ``gem 'rails', '~> 5.2.2'``
- ``gem 'pg', '>= 0.18', '< 2.0'``
- ``gem 'puma', '~> 3.11'``
- ``gem 'bootsnap', '>= 1.1.0'``
- ``gem 'figaro'``
- ``gem 'faraday'``
- ``gem 'fast_jsonapi'``
- ``gem 'bcrypt', '~> 3.1', '>= 3.1.11'``
- ``gem 'rack-cors', require: 'rack/cors'``

##### Testing & Development:
- ``gem 'pry'``
- ``gem 'simplecov'``
- ``gem 'rspec-rails'``
- ``gem 'shoulda-matchers', '~> 3.1'``
- ``gem 'capybara'``
- ``gem 'launchy'``
- ``gem 'webmock'``
- ``gem 'vcr'``
- ``gem 'factory_bot_rails'``

## Install
1 - Setup Environment: Upon download, run ``bundle install``.

2 - Setup DB: ``bundle exec rake db:{drop,create,migrate,seed}``

3 - Setup Dark Sky API:
  - Get an [api_key](https://darksky.net/dev/register)
  - ``bundle exec figaro install``
  - Store API keys in config/application.yml
    - dark_sky_key: <api_key>

4 - Setup Giphy API:
  - Get an [api_key] (https://developers.giphy.com)
  - ``bundle exec figaro install``
  - Store API keys in config/application.yml
    - giphy_key: <api_key>

    ## Testing
    MiniTest has been excluded from this app, opting for RSpec instead.

    Run RSpec via ``bundle exec rspec``

    Test data is mocked with [WebMock](https://github.com/bblimke/webmock) and [VCR](https://github.com/vcr/vcr)

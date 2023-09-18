require 'rails_helper'
require 'webmock/rspec'

RSpec.describe WeatherService do
  describe '#fetch_weather' do
    before do
      WebMock.disable_net_connect!(allow_localhost: true)
    end

    after do
      WebMock.allow_net_connect!
    end

    it 'returns weather data for a valid zip code with a valid API key' do
      zip_code = '90210'

      # Stub the request to return a valid response
      stub_request(:get, /api.openweathermap.org/).
        to_return(
          body: {
            main: { temp: 20 },
            weather: [{ description: 'Sunny' }]
          }.to_json,
          status: 200,
          headers: { 'Content-Type' => 'application/json' }
        )

      weather_data = WeatherService.fetch_weather(zip_code)

      expect(weather_data).to include(zip_code: zip_code, temperature: 20, conditions: 'Sunny')
    end

    it 'raises an error for an invalid API key' do
      zip_code = '90210'
    
      # Stub the request to return a 401 Unauthorized response
      stub_request(:get, /api.openweathermap.org/).
        to_return(status: 401, body: 'Invalid API key')
    
      expect { WeatherService.fetch_weather(zip_code) }.
        to raise_error(StandardError, 'Error fetching weather data: 401 - Invalid API key')
    end
    

    it 'raises an error for an invalid zip code' do
      zip_code = 'INVALID_ZIP'

      # Stub the request to return a 404 Not Found response
      stub_request(:get, /api.openweathermap.org/).
        to_return(status: 404, body: 'City not found')

      expect { WeatherService.fetch_weather(zip_code) }.
        to raise_error(StandardError, 'Error fetching weather data: 404 - City not found')
    end
  end
end

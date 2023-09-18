require 'httparty'

class WeatherService
  OPENWEATHER_API_KEY = ENV['OPENWEATHER_API_KEY'].freeze
  BASE_URL = 'https://api.openweathermap.org/data/2.5/weather'.freeze

  def self.fetch_weather(zip_code)
    response = HTTParty.get(BASE_URL, query: {
      zip: zip_code,
      appid: OPENWEATHER_API_KEY,
      units: 'metric'
    })

    if response.success?
      weather_data = JSON.parse(response.body)
      current_temperature = weather_data['main']['temp']
      weather_description = weather_data['weather'][0]['description']
      {
        zip_code: zip_code,
        temperature: current_temperature,
        conditions: weather_description
      }
    else
      raise StandardError, "Error fetching weather data: #{response.code} - #{response}"
    end
  end
end

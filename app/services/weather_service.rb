require 'httparty'
require 'redis'

class WeatherService
  OPENWEATHER_API_KEY = ENV['OPENWEATHER_API_KEY'].freeze
  BASE_URL = 'https://api.openweathermap.org/data/2.5/weather'.freeze

  def self.fetch_weather(zip_code)
    redis = Redis.new(host: 'redis', port: 6379, db: 0).freeze
    cached_weather_data = redis.get("weather/#{zip_code}")

    if cached_weather_data
      return JSON.parse(cached_weather_data, symbolize_names: true)
    end
    response = HTTParty.get(BASE_URL, query: {
      zip: zip_code,
      appid: OPENWEATHER_API_KEY,
      units: 'metric'
    })

    if response.success?
      weather_data = JSON.parse(response.body)
      current_temperature = weather_data['main']['temp']
      weather_description = weather_data['weather'][0]['description']
      data = {
        zip_code: zip_code,
        temperature: current_temperature,
        conditions: weather_description
      }
      redis.set("weather/#{zip_code}", data.to_json)
      redis.expire("weather/#{zip_code}", 1.hour.to_i)
      data
    else
      raise StandardError, "Error fetching weather data: #{response.code} - #{response}"
    end
  end
end

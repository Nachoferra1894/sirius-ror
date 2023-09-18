require 'dotenv/load'

class WeatherController < ApplicationController
    def get_weather
        zip_code = params[:zip_code]
        
        if zip_code.nil?
          render json: { error: "Zip code is required" }, status: :bad_request
          return
        end
    
        begin
          weather_data = WeatherService.fetch_weather(zip_code)
          render json: weather_data, status: :ok
        rescue StandardError => e
          render json: { error: "Error fetching weather data: #{e.message}" }, status: :internal_server_error
        end
    end
end
  
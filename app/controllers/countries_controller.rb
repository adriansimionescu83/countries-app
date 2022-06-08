require "json"
require "open-uri"

class CountriesController < ApplicationController
  skip_after_action :verify_authorized
  include Pagy::Backend
  include HTTParty

  def index
    @pagy, @countries = pagy(Country.all)
    # api_current_weather(@countries.entries)

    # Add here the logic to retrieve the weather info for each country
  end

  def show
    api_key = ENV["WEATHER_API_KEY"]

    @country = Country.find(params[:id])

    latlong = "#{@country.latitude},#{@country.longitude}"
    url = "https://api.weatherapi.com/v1/forecast.json?key=#{api_key}&q=#{latlong}&days=7&aqi=no&alerts=no"

    begin
      response = HTTParty.get(url)
      if response.success?
        @country.forecast_weather = []
        weather = JSON.parse(response.body)["forecast"]["forecastday"]
        weather.each do |daily_weather|
          @country.forecast_weather << {
            date: daily_weather["date"],
            avgtemp_c: daily_weather["day"]["avgtemp_c"].round().to_s,
            avgtemp_f: daily_weather["day"]["avgtemp_f"].round().to_s,
            condition: daily_weather["day"]["condition"]["icon"],
            avghumidity: daily_weather["day"]["avghumidity"].to_s
          }
        end
        @country.save!
      end
      rescue HTTParty::Error
        puts "Unable to find location"

      rescue StandardError
        # rescue instances of StandardError,
        # i.e. Timeout::Error, SocketError etc
    end
  end

  def api_current_weather(countries)
    api_key = ENV["WEATHER_API_KEY"]

    countries.each do |country|
      latlong = "#{country.latitude},#{country.longitude}"
      url = "https://api.weatherapi.com/v1/current.json?key=#{api_key}&q=#{latlong}&aqi=no"

      begin
        response = HTTParty.get(url)
          if response.success?
            weather = JSON.parse(response.body)["current"]
            country.current_weather["last_updated"] = weather["last_updated"]
            country.current_weather["temp_c"] = weather["temp_c"].round().to_s
            country.current_weather["temp_f"] = weather["temp_f"].round().to_s
            country.current_weather["condition"] = weather["condition"]["icon"]
            country.current_weather["humidity"] = weather["humidity"].to_s
            country.save!
            puts country.current_weather

          else
            country.current_weather["temp_c"] = "N/A"
            country.current_weather["temp_f"] = "N/A"
            country.current_weather["condition"] = "not_applicable.png"
            country.current_weather["humidity"] = "N/A"
            country.save!
          end
        rescue HTTParty::Error
          puts "Unable to find location"

        rescue StandardError
          # rescue instances of StandardError,
          # i.e. Timeout::Error, SocketError etc
      end
    end
  end

end

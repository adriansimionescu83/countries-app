# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "json"
require "open-uri"


# Uncomment the below section and run the rails db:seed command in your terminal in order to seed the database with countries fetch from restcounteries.com

# url = 'https://restcountries.com/v3.1/all'

# countries_serialized = URI.parse(url).read
# countries = JSON.parse(countries_serialized)

# countries.each do |country|
#   name = country["name"]["official"].to_s
#   unless country["currencies"].nil?
#     currencies = country["currencies"]["#{country["currencies"].keys.first}"]["name"]
#   else
#     currencies = "No currency"
#   end
#   population = country["population"].to_i
#   continent = country["continents"].first.to_s
#   latitude = country["latlng"].first
#   longitude = country["latlng"].last
#   unless country["capital"].nil?
#     capital = country["capital"].first.to_s
#   else
#     capital = "No capital"
#   end

#   Country.create!(
#     name: name,
#     capital: capital,
#     latitude: latitude,
#     longitude: longitude,
#     currencies: currencies,
#     population: population,
#     continent: continent
#   )
# end


  api_key = ENV["WEATHER_API_KEY"]

  @country = Country.find(1)

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

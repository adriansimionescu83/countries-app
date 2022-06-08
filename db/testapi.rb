require "json"
require "open-uri"

# api_key = ENV["WEATHER_API_KEY"]
api_key = "0fb56bc668ce49d582a94053220206"
location = "London"
url = "https://api.weatherapi.com/v1/current.json?key=#{api_key}&q=#{location}&aqi=no"

weather_serialized = URI.parse(url).read
weather = JSON.parse(weather_serialized)["current"]

Country.all.each do |country|
  country.current_weather.store[:temp_c] = weather["temp_c"].round().to_s
end



puts "#{weather["temp_c"].round().to_s}"
puts "#{weather["temp_f"].round().to_s}"
puts weather["condition"]["icon"]
puts "#{weather["humidity"]}"

# README

The purpose of this app is to allow the users to check the weather details of specific countries. To achieve that the database is seeded with the list of countries from  https://restcountries.com and then for each country the app is calling the API https://www.weatherapi.com/ to fetch data related to current and forecasted weather of each country.
With regards to the weather API call, there are two scenarios in which this call is done:
1. On the index page of countries, the API is called only for the countries displayed on that page
2. On the show page of each country, there is another API call only for that country to fetch the forecasted weather info. Note: the free version of the API provides only 3 days forecast. For more days you will need to apply for the paid versions.

The authentication is done using Devise.
The pagination is done using Pay gem.

This app has been built with :
* Ruby version: 3.1.2

* Rails version 7.0.3

* Database : Postgresql

Deployment instructions:
1. After cloning the repo locally run bundle:install and then rails db:migrate
2. Ensure that in the the seeds.rb file the script that calls the restcountries api is uncommented
3. Then run rails db:seed. This will populate the database with the list of countries
4. Create an account on the https://www.weatherapi.com/ and then copy the api key in your local ".env" file
5. Run rails s and enjoy :)


Further improvements needed:
1. Add to Favorites is not fully implemented yet
2. Devise has not been fully set with regards to email sending (e.g. if you forgot your password)
3. The API call for country index takes a bit too long. Further improvement would be to limit the search only for countries for which the weather info has not been updated recently.

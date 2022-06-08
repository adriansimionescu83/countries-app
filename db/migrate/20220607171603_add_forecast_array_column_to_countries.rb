class AddForecastArrayColumnToCountries < ActiveRecord::Migration[7.0]
  def change
    add_column :countries, :forecast_weather, :text
  end
end

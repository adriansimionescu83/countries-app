class AddWeatherColumnsToCountries < ActiveRecord::Migration[7.0]
  def change
    add_column :countries, :current_weather, :json, default: {last_updated: '', temp_c: '', temp_f: '', humidity: '', condition: ''}
  end
end

class CreateCountries < ActiveRecord::Migration[7.0]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :continent
      t.string :currencies
      t.integer :population
      t.string :capital

      t.timestamps
    end
  end
end

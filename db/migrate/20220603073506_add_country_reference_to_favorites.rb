class AddCountryReferenceToFavorites < ActiveRecord::Migration[7.0]
  def change
    add_reference :favorites, :country, null: false, foreign_key: true
  end
end

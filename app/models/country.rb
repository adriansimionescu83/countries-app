class Country < ApplicationRecord
  has_many :favorites
  has_many :users, through: :favorites

  validates :name, presence: true
  validates :population, presence: true
  validates :continent, presence: true
  serialize :forecast_weather, Array
end

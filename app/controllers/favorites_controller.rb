class FavoritesController < ApplicationController
  def index
    @favorites = policy_scope(Favorite).order(created_at: :asc)
  end

  def create
    @country = Country.find(params[:id])
    @favorite = Favorite.new(country: @country)
    if @favorite.save
      { errors: [] }.to_json
    else
      { errors: errors.messages }.to_json
    end
    authorize @favorite
  end

  def update
    favorite = Favorite.where(country: Country.find(params[:country]), user: current_user)
    if favorite == []
      #create the favorite
      Favorite.create(country: Country.find(params[:country]), user: current_user)
      @favorite_exists = true
    else
      #delete the favorite
      favorite.destroy_all
      @favorite_exists = false
    end
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    authorize @favorite
  end

end

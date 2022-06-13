class FavoritesController < ApplicationController
  def index
    @favorites = policy_scope(Favorite).order(created_at: :asc)
  end

  def update_favorites
    favorite = Favorite.where(country: Country.find(params[:country_id]), user: current_user)

    if favorite == []
      #create the favorite
      Favorite.create(country: Country.find(params[:country_id]), user: current_user)
      @favorite_exists = true
    else
      #delete the favorite
      favorite.destroy_all
      @favorite_exists = false
    end
    respond_to do |format|
      format.html {}
      format.json {
        render json: {
          full: @favorite_exists
        }
      }
    end
    authorize favorite

  end

  def show
    @favorite = Favorite.find(params[:id])
    authorize @favorite
  end


end

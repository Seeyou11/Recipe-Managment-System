class FavoritesController < ApplicationController
  before_action :set_favorite, only: %i[ show edit update destroy ]

  def create
    recipe = Recipe.find(params[:favorite][:recipe_id])
    current_user.favorite_recipes << recipe unless current_user.favorite_recipes.include?(recipe)
    redirect_to recipes_url
  end

  def destroy
    if params[:favorite].present?
      recipe = Recipe.find(params[:favorite][:recipe_id])
      current_user.favorite_recipes.destroy(recipe)
    end
      redirect_to recipes_url
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite
      @favorite = Favorite.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def favorite_params
      params.fetch(:favorite, {}).permit(:value, :recipe_id, :user_id)
    end
end

class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy ]
  before_action :require_user, except: %i[ show index ]
  before_action :require_same_user, only: %i[ edit update destroy ]

  def index
    @q = Recipe.ransack(params[:q])
    if params[:q]
      @recipes = @q.result(distinct: true).order(created_at: :desc).paginate(page: params[:page], per_page: 6)
    else
      @recipes = Recipe.order(created_at: :desc).paginate(page: params[:page], per_page: 6)
    end
  end

  # GET /recipes/1 or /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
    @categories = Category.all
  end

  # GET /recipes/1/edit
  def edit
    @categories = Category.all
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    @categories = Category.all
      if @recipe.save
          flash[:success] = "Recipe was successfully created."
          redirect_to recipes_url
      else
          flash[:error] = "Unable to create recipe!"
          redirect_to new_recipe_url
      end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
      if @recipe.update(recipe_params)
          flash[:success] = "Recipe was successfully updated."
          redirect_to recipes_url
      else
          flash[:error] = "Unable to update recipe!"
          redirect_to edit_recipe_url
      end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url(@recipe), notice: "Recipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
            params.require(:recipe).permit(:title, :description, :preparation_steps, :category_id, :file)
    end

    def require_same_user
      if current_user != @recipe.user && !current_user.admin?
         flash[:notice] = "You can only edit or delete your own recipe."
         redirect_to @recipe  
      end
    end
end

class CategoriesController < ApplicationController
    before_action :set_category, only: %i[ show edit update destroy ]
    before_action :require_admin, except: %i[ show index ]
  
    def new
        @category = Category.new
    end

    def index
        @q = Category.ransack(params[:q])
        if params[:q]
        @categories = @q.result(distinct: true).order(created_at: :desc).paginate(page: params[:page], per_page: 6)
        else
        @categories = Category.order(created_at: :desc).paginate(page: params[:page], per_page: 6)
        end
    end

    def show
    @category = Category.find(params[:id])
    @q = @category.recipes.ransack(params[:q])
    @recipes = @q.result(distinct: true).order(created_at: :desc).paginate(page: params[:page], per_page: 6)
    end

    def edit
    end

    def create
        @category = Category.new(category_params)
        @category.user = current_user
        if @category.save
            flash[:success] = "Category was successfully created."
            redirect_to categories_url
        else
                    #  flash[:error] = "#{@category.errors.full_messages.join(', ')}"
            flash[:error] = "Unable to create Category!"
            redirect_to new_category_url
        end
    end

    
    def update
        if @category.update(category_params)
            flash[:success] = "Category was successfully updated."
            redirect_to category_url(@category)
        else
            flash[:error] = "Unable to update Category!"
            redirect_to edit_category_url
        end
    end


    private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, :description)
    end

    def require_admin
       if !(logged_in? && current_user.admin?)
        flash[:notice] = "Only admins can perform that action."
        redirect_to categories_path
       end
    end

    def require_same_user
      if current_user != @recipe.user && !current_user.admin?
         flash[:notice] = "You can only edit or delete your own recipe."
         redirect_to @recipe  
      end
    end
end
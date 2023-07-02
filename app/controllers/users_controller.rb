class UsersController < ApplicationController
    before_action :set_user, only: %i[ show edit update destroy ]
    # before_action :require_user, except: %i[ show index ]
    before_action :require_same_user, only: %i[ edit update destroy ]

    def new
        @user = User.new
        # @recipes = recipes.new
    end
    
    def index
        @users =  User.paginate(page: params[:page], per_page: 6)
    end

    def edit
    end

   
    def show
        user_recipes = @user.recipes
        favorite_recipes = current_user.favorite_recipes
        combined_recipes = (user_recipes + favorite_recipes).uniq
        @q = Recipe.where(id: combined_recipes.pluck(:id)).ransack(params[:q])
        @recipes = @q.result(distinct: true).order(created_at: :desc).paginate(page: params[:page], per_page: 6)
    end


    def create
        @user = User.new(user_params)
            if @user.save
                session[:user_id] = @user.id
                flash[:success] = "Welcome #{@user.username}, you have successfully signup."
                redirect_to user_url(@user)
            else
                render :new, status: :unprocessable_entity
            end
    end 

    def update
            if @user.update(user_params)
                 flash[:success] = "Dear #{@user.username}, you have successfully updated your account."
                redirect_to user_url
            else
                render :edit, status: :unprocessable_entity
            end
    end

    def destroy
        if current_user.admin?
            @user.destroy
            flash[:notice] = "User account deleted successfully."
            redirect_to users_path
        else
            @user.destroy
            session[:user_id] = nil if @user == current_user
            respond_to do |format|
            format.html { redirect_to recipes_url, notice: "Your profile was successfully destroyed." }
            format.json { head :no_content }
            end
        end
    end


    private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation, :file)
    end

    def require_same_user
      if current_user != @user && !current_user.admin?
         flash[:error] = "You can only edit or delete your own profile."
         redirect_to @user  
      end
    end
end
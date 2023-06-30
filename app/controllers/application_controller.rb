class ApplicationController < ActionController::Base
    
    # so this now makes current user available to our viewers as well, not just to our controllers.
    helper_method :current_user, :logged_in?

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logged_in?
        # turning current_user into boolean
        !!current_user
    end

    def require_user
        if !logged_in?
            flash[:error] = "You must be logged in to perform that action."
            redirect_to login_path
        end
    end
    

end

class PasswordsController < ApplicationController
#  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :require_user, except: [:edit, :update]

  def edit
    @user = current_user
  end

  def update
    # debugger
    @user = current_user

    if @user.authenticate(params[:user][:current_password])
      if @user.update(password_params)
        flash[:success] = "Password updated successfully!"
        redirect_to user_path(@user)
      else
        
        flash[:error] = "Failed to update password"
        redirect_to edit_password_path
      end
    else
      flash[:error] = "Incorrect current password"
      redirect_to edit_password_path
    end
  end

  private
  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
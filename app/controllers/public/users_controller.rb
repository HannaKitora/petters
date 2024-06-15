class Public::UsersController < ApplicationController
  
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def index
    # if admin
    @users = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @pets = Pet.all
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(current_user)
    else
      flash.now[:notice]
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
  
end

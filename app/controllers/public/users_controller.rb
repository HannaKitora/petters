class Public::UsersController < ApplicationController
  
  before_action :ensure_guest_user, only: [:edit]
  before_action :ensure_login_user, only: [:edit, :update]
  
  def index
    if params[:id].present?
      @user = User.find(params[:id])
    end
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @users = User.all
    @pets = Pet.where(user_id: @user.id).order(created_at: :desc)
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
  
  def withdrawal
    @user = User.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  def followings
    @user = User.find(params[:id])
    @users = @user.followings
  end
  
  def followers
    @user = User.fimd(params[:id])
    @users = @user.followers
  end
  
  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:pet_id)
    @favorite_pets = Pet.find(favorites)
  end
    
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def pet_params
    params.require(:pet).permit(:name, :kind, :caption, :image)
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      flash[:notice] = "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      redirect_to user_path(current_user)
    end
  end
  
  def ensure_login_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      flash[:notice]="ログインが必要です"
      redirect_to root_path
    end
  end
end

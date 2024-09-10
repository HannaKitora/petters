class Public::PetsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_login_user

  def new
    @pet = Pet.new
  end
  
  def create
    @pet = Pet.new(pet_params)
    @pet.user_id = current_user.id
    if @pet.save
      flash[:notice] = "You have posted pet successfully."
      redirect_to pets_path(params[:id])
    else
       redirect_to new_pet_path, flash: { error: @pet.errors.full_messages }
    #   flash.now[:alert] = "No content!"
    #   render :edit, status: :unprocessable_entity
    end
  end

  def index
    @pets = Pet.left_joins(:week_favorites).group(:id).order("count(favorites.pet_id) desc").page(params[:page])
    @pet = Pet.new
    @user = current_user
    @users = User.where(params[:user_id])
    
    if params[:kind_id]
      @pets = Pet.where(kind_id: params[:kind_id]).page(params[:page])
    end
      
  end

  def show
    @pet = Pet.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @user = current_user
    @pet = Pet.find(params[:id])
    unless @pet.user == current_user
      redirect_to pets_path
    end
  end
  
  def update
    @pet = Pet.find(params[:id])
    if @pet.update(pet_params)
      @user = current_user
      flash[:notice] = "You have updated pet successfully."
      redirect_to pet_path(@pet.id)
    # else
      # redirect_to edit_pet_path(@pet.id), flash: { error: @pet.errors.full_messages }
      # flash.now[:notice]
      # render :edit
    end
  end

  def destroy
    pet = Pet.find(params[:id])
    pet.destroy
    redirect_to pets_path
  end
  
  private
  
  def pet_params
    params.require(:pet).permit(:name, :image, :kind_id, :caption)
  end
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :user_id)
  end
  
  def ensure_login_user
    # user = User.find(params[:user_id])
    unless user_signed_in?
      flash[:alert] = "ログインが必要です"
      redirect_to root_path
    end
  end
end

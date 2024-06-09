class PetsController < ApplicationController
  def new
    @pet = Pet.new
  end
  
  def create
    @pet = Pet.new(pet_params)
    @pet.user_id = current_user.id
    @pet.save
    redirect_to pets_path(params[:id])
  end

  def index
    @pets = Pet.all
    @pet = Pet.new
    @user = current_user
  end

  def show
    @pet = Pet.find(params[:id])
    @pet =@pet.user
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
    else
      flash.now[:notice]
      render :edit
    end
  end

  def destroy
    pet = Pet.find(params[:id])
    pet.destroy
    redirect_to pets_path
  end
  
  private
  
  def pet_params
    params.require(:pet).permit(:name, :image, :kind, :caption)
  end
  
end

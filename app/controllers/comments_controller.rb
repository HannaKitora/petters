class CommentsController < ApplicationController
  
  def create
    pet = Pet.find(params[:pet_id])
    comment = current_user.comments.new(comment_params)
    comment.pet_id = pet.id
    comment.save
    redirect_to pet_path(pet)
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to pet_path(params[:pet_id])
  end
  
  private
  
  def pet_params
    params.require(:comment).permit(:comment)
  end
end

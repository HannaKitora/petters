class Admin::KindsController < ApplicationController
  layout 'admin'
  
  def new
    @kind = Kind.new
    @kinds = Kind.all
    
  end
  
  def create
    @kind = Kind.new(kind_params)
    if @kind.save
      flash[:notice] = "You have registered the new kind successfully!"
      redirect_to new_admin_kind_path
    else
      flash[:notice] = "Failed to register the new kind...."
      render :new
    end
  end
  
  def index
    @kinds = Kind.all
  end
  
  def edit
    @kind = Kind.find(params[:id])
  end
  
  def update
    @kind = Kind.find(params[:id])
    if @kind.update(kind_params)
      flash[:notice] = "You have updated kind successfully!"
      render :index
    else
      flash.now[:notice]
      render :edit
    end
  end
  
  def destroy
    @kinds = Kind.find(params[:id])
    @kinds.destroy
    flash[:notice] = "Deleted kind!!"
    redirect_to new_admin_kind_path
  end

  private

  def kind_params
    params.require(:kind).permit(:kind)
  end

end
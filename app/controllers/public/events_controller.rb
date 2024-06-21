class Public::EventsController < ApplicationController
  
  def index
    @events = AdminEvent.all
  end

  def show
    @event = AdminEvent.find(params[:id])
  end
  
  def update
    @event = AdminEvent.find(params[:id])
    if @event.update(admin_event_params)
      flash[:notice] = "You have updated pet successfully."
      redirect_to event_path(@event.id)
    else
      flash.now[:notice]
      render :edit
    end
  end
  
  private
  
  def admin_event_params
    params.require(:event).permit(:name, :image, :price, :detail)
  end

end

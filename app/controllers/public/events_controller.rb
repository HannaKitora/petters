class Public::EventsController < ApplicationController
  
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @entry = Entry.new
   
  end
  
  def update
    @event = Event.find(params[:id])
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
    params.require(:event).permit(:name, :image, :price, :detail, :date)
  end

end
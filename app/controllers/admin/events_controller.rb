class Admin::EventsController < ApplicationController
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to admin_event_path(@event)
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end

  def index
    @events = Event.all
  end

  def edit
    @event = Event.find(params[:id])
  end
  
  def show
    @event = Event.find(params[:id])
   
  end
  
  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:notice] = "You have updated pet successfully."
      redirect_to admin_event_path(@event.id)
    else
      flash.now[:notice]
      render :edit
    end
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_to events_path
  end
  
  private
  
  def event_params
    params.require(:event).permit(:name, :image, :price, :detail)
  end

end

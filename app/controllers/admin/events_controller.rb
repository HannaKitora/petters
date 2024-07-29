class Admin::EventsController < ApplicationController
  layout 'admin'
  # before_action :authenticate_admin!
  
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
    date = params[:date]
    @events = Event.where("date >= ?", Date.today).order(date: :asc)
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
    @events = Event.find(params[:id])
    @events.destroy
    redirect_to admin_events_path
  end
  
  private
  
  def event_params
    params.require(:event).permit(:name, :image, :price, :detail, :date)
  end

end

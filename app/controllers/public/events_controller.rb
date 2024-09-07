class Public::EventsController < ApplicationController
  
  def index
    date = params[:date]
    @events = Event.where("date >= ?", Date.today).order(date: :asc)
    # @events = @events.map do |event|
    #   event.define_singleton_method(:title) { event.name }
    #   event
    # end
    respond_to do |format|
      format.html
      format.json { render 'calendar' }
    end
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
    params.require(:event).permit(:title, :image, :price, :detail, :date)
  end

end
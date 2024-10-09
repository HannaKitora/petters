class Public::EntriesController < ApplicationController
  before_action :authenticate_user!
  # before_action :ensure_guest_user, only: [:creat, :update, :edit, :new, :destroy]
  
  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.user_id = current_user.id
    @event = @entry.event_id
    if @entry.save!
      # redirect_to new_order_path(@entry)
      redirect_to entry_path(@entry)
    else
      flash[:notice] = 'Your entry has been failed!'
      redirect_to events_path
    end
  end
  
  # def increase
  #   @entry.increment!(:amount, 1)
  #   redirect_to request.referer, notice: 'Successfully updated your cart'
  # end

  # def decrease
  #   decrease_or_destroy(@entry)
  #   redirect_to request.referer, notice: 'Successfully updated your cart'
  # end

  def show
    @entry = Entry.find(params[:id])
    @event = Event.find(@entry.event_id)
    # redirect_to new_order_path
  end
  
  def index
    @entry = Entry.new
    @entries = current_user.entries
    # date = params[:event_date]
    # @events = @entries.event.where("event_date > ?", Date.today).order(event_date: :asc)
    
    # target_event_ids = current_user.entries.select(:event_id)
    # @events = Event.sort_by_date(target_event_ids)
    # @events = Event.where("event_date >= ?", Date.today).order(event_date: :asc)
    # @sum = 0
  end
  
  def update
    @entry = Entry.find(params[:id])
   
    if @entry.update(entry_params)
      flash[:notice] = "You have updated entry successfully."
      redirect_to entry_path(@entry)
    else
      flash.now[:notice]
      render :index
    end
    
  end
  
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy
    flash[:notice] = "You have deleted your entry!"
    redirect_to entries_path
    # redirect_back(fallback_location: root_path)
  end

  private
  
  def entry_params
    params.require(:entry).permit(:amount, :event_id, :tax_included_price, :event_data)
    params.fetch(:entry, {}).permit(:amount, :event_id, :user_id, :event_date)
  end
  
  def event_params
    params.require(:event).permit(:event_id, :date)
  end
  
end

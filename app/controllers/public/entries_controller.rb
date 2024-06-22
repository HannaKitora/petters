class Public::EntriesController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  
  def new
    @entry = Entry.new
  end

  def create
    entry = Entry.new(entry_params)
    entry.user_id = current_user.id
    entry.event_id = entry_params[:event_id]
    if entry.save
      current_user.entries.each do |entry|
        @entry = Entry.new
        @entry.event_id = @entry.id
        @entry.amount = entry.amount
        @entry.tax_included_price = (entry.event.price*1.1).floor
        @entry.save
      render :thanks
    else
      flash.now[:alert] = 'failed to entry'
      redirect_to entries_path
    end
  end

  def index
    @entries = Entry.all
    event.id = entry.event.id
    render :new
  end

  def show
  end
  
  def destroy_all
    Enrty.destroy_all
    redirect_back(fallback_location: root_path)
  end
  
  def confirm
    @entries = Entry.find(params[:id])
    @entry = Event.find(params[:id])
  end

  def thanks
  end

  
  private
  def entry_params
    params.require(:entry).permit(:amount, :event_id, :user_id)
  end
end

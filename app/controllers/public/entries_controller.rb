class Public::EntriesController < ApplicationController
  def new
    @entry = Entry.new
  end

  def confirm
    @entries = Entry.find(params[:id])
    @entry = Event.find(params[:id])
    render :thanks
  end

  def thanks
  end

  def create
    entry = Entry.new(entry_params)
    entry.user_id = current_user.id
    entry.event_id = entry_params[:event_id]
    entry.save
    redirect_to entries_path
  end

  def index
    @entries = Entry.all
  end

  def show
    @entry = Entry.find(params[:id])
  end
  
  def destroy_all
    Enrty.destroy_all
    redirect_back(fallback_location: root_path)
  end

  
  private
  def entry_params
    params.require(:entry).permit(:amount, :event_id)
  end
end

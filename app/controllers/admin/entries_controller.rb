class Admin::EntriesController < ApplicationController
  layout 'admin'
  
  def index
    @entries = Entry.all
    @events = Event.where(params[:event_id])
  end
  
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy
    flash[:notice] = "You have deleted entry successfly!"
    redirect_to admin_entries_path
    # render :index
  end
end

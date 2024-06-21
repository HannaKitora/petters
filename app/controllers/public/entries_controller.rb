class Public::EntriesController < ApplicationController
  def new
    @entry = Entry.new
  end

  def confirm
    @entries = Entry.find(params[:id])
    @entry = Event.find(params[:id])
  end

  def thanks
  end

  def create
    @entry = Entry.new(entry_params)
    if @entry.save
      redirect_to entries_path
    else
      render :new
    end
  end

  def index
    @entries = Entry.find(params[:id])
  end

  def show
    @entry = Event.find(params[:id])
  end
  
  private
  def entry_params
    params.requre(:entry).permit(:amount)
  end
end

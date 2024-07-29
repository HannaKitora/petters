class Public::EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:creat, :update]
  
  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.user_id = current_user.id
    @entry.event_id = entry_params[:event_id]
    if @entry.save
      current_user.entries.each do |entry|
        @entry = Entry.new
        @entry.event_id = @entry.id
        @entry.amount = entry.amount
        @entry.tax_included_price = (entry.event.price*1.1).floor
        @entry.save
      end
      render :thanks
    else
      flash.now[:alert] = 'failed to entry'
      redirect_to entries_path
    end
  end

  def index
    @entry = Entry.new
    # @events = Event.find_by_id(params[:event_id])
    # @entry = Entry.new(event_date: entry_params[:event_date])
    @entry.event_date = entry_params[:event_date]
    # @events = Event.where("event_date >= ?", Date.today).order(event_date: :asc)
    
    target_event_ids = current_user.entries.select(:event_id)
    @events = Event.where(id: target_event_ids).where("date >= ?", Date.today).order(date: :asc)
    # @sum = 0
  end

  def show
    @entry = Entry.find(params[:id])
  end
  
  def update
    @entry = Entry.find(params[:id])
    if @entry.update(entry_params)
      flash[:notice] = "You have updated entry successfully."
      render :index
    else
      flash.now[:notice]
      render :index
    end
  end
  
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy
    redirect_back(fallback_location: root_path)
  end
  
  # def confirm
  #   @entries = Entry.all
  #   @sum = 0
  # end

  def thanks
    flash[:notice] = "You have entried successfully."
  end

  
  private
  def entry_params
    # params.require(:entry).permit(:amount, :event_id, :user_id, :date)
    params.fetch(:entry, {}).permit(:amount, :event_id, :user_id, :event_date)
  end
  
  def event_params
    params.require(:event).permit(:event_id, :date)
  end

  def ensure_guest_user
    @user = User.find(params[:user_id])
    if @user.guest_user?
      flash[:notice] = "ユーザー登録をお願いします。"
      redirect_to user_path(current_user)
    else
      
    end
  end

end

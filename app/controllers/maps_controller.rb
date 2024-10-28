class MapsController < ApplicationController
  def show
    @events = Event.where(id: params[:id])
    redirect_to events_path if @events.blank?
    respond_to do |format|
      format.html
      format.json
    end
  end
end

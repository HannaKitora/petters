class Public::OrderDetailsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    # @orders = Order.where(params[:order_id])
    @orders = current_user.orders
    event = Event.where(params[:event_id])
    
  end
  
  
end

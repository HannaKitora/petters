class Public::OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @order = Order.new
    @adresses = Address.all
  end
  
  def create
    @order = Order.new(order_params)
    
    if @order.save
      redirect_to orders_confirm_path
    end
  end
  
  def confirm
    @order = Order.new(Order_params)
    if params[:order][:select_address] == "0"
      @order.postal_code = current_user.postal_code
      @order.address = current_user.address
      
      
    end
    
  end
    
end

class Public::OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @order = Order.new
    @addresses = Address.all
  end
  
  def create
    @order = Order.new(order_params)
    @order.save
    
    # redirect_to orders_confirm_path
    @order_details = OrderDetail.new
    @order_details.order_id = @order.id
    @entry = Entry.find_by(params[:entry_id])
    @order_details.event_id = @entry.event_id
    @order_details.price = @entry.tax_included_price
    @order_details.amount = @entry.amount
    # @order_details.subtotal = @entry.subtotal
    @order_details.making_status = 0
    if @order_details.save!
      Entry.destroy_all
      redirect_to orders_confirm_path
    end
  end
  
  def confirm
    @order = Order.new(order_params)
    @entry = Entry.find_by(params[:entry_id])
    @user = current_user
    if params[:order][:select_address] == "1"
      if Address.exists?(username: params[:order])
        @addresses = Address.find(params[:order][:address_id])
        # @order.postal_code = @address.postal_code
        @order.address = @address.full_address
        @order.username = @address.address_username
      end
    elsif params[:order][:select_address] == "2"
      address_new = current_user.addresses.new(address_params)
      if address_new.save
        # @order.user_id = current_user.id
      else
        render :new
      end
    end
    # @entry = current_user.entries.all
    @entry = Entry.find_by(params[:entry_id])
    
    if @order.save
      render :thanks
    end
  end
  
  def thanks
  end
  
  private
  
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :username, :user_id, :total_payment, :status)
  end
  
  def entry_params
    params.require(:entry).permit(:amount, :event_id, :tax_included_price)
    params.require(:event).permit(:eventid, :data, :image, :with_tax_price, :title)
  end
  
  def entry_nill
    entries = current_user.entries
    if entries.blank?
      redirect_to entry_path
    end
  end
  
  def address_params
    params.require(:order).permit(:address_username, :address)
  end
  
end

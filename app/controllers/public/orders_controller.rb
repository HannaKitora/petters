class Public::OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @order = Order.new
    @addresses = Address.all
    @amount = params[:entry][:amount]
    @entry_id = params[:entry][:entry_id]
    @subtotal = params[:entry][:subtotal]
    @event_id = Entry.find(params[:entry][:entry_id]).event_id
  end
  
  def create
    @order = Order.new(order_create_params)
    @amount = params[:amount]
    @entry_id = params[:entry_id]
    @subtotal = params[:subtotal]
    @event_id = order_detail_params[:event_id]
    @order_detail = OrderDetail.new
    @order_detail.order_id = @order.id
    @entry = Entry.find(params[:entry_id])
    # @entry = Entry.find(params[:entry_id])
    @order_detail.event_id = params[:event_id]
    @order_detail.price = @entry.event.with_tax_price
    @order_detail.amount = @entry.amount
    @order_detail.making_status = 0
    
    if @order.save
      @order_detail.order = @order
      @order_detail.save!
     
      Entry.destroy_all
      render :thanks
    else
      redirect_to events_path
    end
    
  end
  
  def confirm
    @order = Order.new(order_params)
    @user = current_user
    @amount = params[:order][:amount]
    @entry_id = params[:order][:entry_id]
    @subtotal = params[:order][:subtotal]
    
    if params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.username = @address.address_username
    else
      @address = current_user.addresses.new
      @address.address = params[:order][:address]
      @address.postal_code = params[:order][:postal_code]
      @address.address_username = params[:order][:address_username]
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.username = @address.address_username
    end
    @event_id = params[:order][:event_id]
    @order.user_id = current_user.id
    @entry = Entry.find_by(params[:entry_id])
    # unless Address.exists?  #追記
      # @order.postal_code = @address.postal_code
    
    # else
    #   @address = Address.where(params[:address_id])
    #   # @order.postal_code = @address.postal_code
    #   @order.address = @address.full_address
    #   @order.username = @address.address_username
    # end
  end
  
  def thanks
  end
  
  def index
    @orders = Order.all
    @order_details = OrderDetail.all
    # byebug
    if order_detail_params[:id].present?
      @order = Order.find(params[:id])
      # @order_detail = @order.order_details.find_by(params[:order_detail_id])
      @order_detail.event_id = params[:event_id]
      @order_detail.price = @entry.event.with_tax_price
      @order_detail.amount = @entry.amount
      @order_detail.making_status = 0
      # @order = @order.order_detail
    end
  end
  
  def show
    @order = Order.find(params[:id])
    @order_detail = @order.order_details.find_by(params[:order_detail_id])
  end
  
  private
  
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :username, :user_id, :total_payment, :status)
  end
  
  def order_create_params
    params.permit(:payment_method, :postal_code, :address, :username, :user_id, :total_payment, :status)
  end
  
  def order_detail_params
    params.permit(:event_id)
  end
  
  def entry_params
    params.require(:entry).permit(:amount, :event_id, :subtotal)
    params.require(:event).permit(:event_id, :data, :image, :with_tax_price, :title)
  end
  
  def entry_nill
    entries = current_user.entries
    if entries.blank?
      redirect_to entry_path
    end
  end
  
  def address_params
    params.require(:order).permit(:address_username, :address, :postal_code)
  end
  
  # def address_params
  #   params.require(:address).permit(:address_username, :address, :postal_code)
  # end
  
end

class Public::OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def new
    # byebug
    @order = Order.new
    @addresses = Address.all
    @amount = params[:entry][:amount]
    @entry_id = params[:entry][:entry_id]
    @subtotal = params[:entry][:subtotal]
    @event_id = params[:entry][:event_id]
  end
  
  def create
    @order = Order.new(order_create_params)
    # byebug
    # redirect_to orders_confirm_path
    @amount = params[:amount]
    @entry_id = params[:entry_id]
    @subtotal = params[:subtotal]
    @event_id = order_detail_params[:event_id]
    
    
    @order_detail = OrderDetail.new
    @order_detail.order_id = @order.id
    @entry = Entry.find(params[:entry_id])
    @order_details.event_id = @entry.event_id
    @order_details.price = @entry.event.with_tax_price
    @order_detail.subtotal = @entry.subtotal
    @order_detail.amount = @entry.amount
    @order_detail.payment_method = @order.payment_method
    @order_detail.making_status = 0
    
    # if current_user.entry_nill?
    #   flash[:danger] = 'カートが空です。イベントを選択してください。'
    #   render "entries/index", status: :unprocessable_entity
    #   return
    # end
    
    @order_detail.save!
    if @order.save
      Entry.destroy_all
      render :thanks
    else
      redirect_to events_path
    end
  end
  
  def confirm
    # byebug
    @order = Order.new(order_create_params)
    @user = current_user
    @amount = params[:order][:amount]
    @entry_id = params[:order][:entry_id]
    @subtotal = params[:order][:subtotal]
    @address = Address.set_address(params[:order][:select_address], 
                                  params[:order][:address_id], 
                                  current_user,
                                  address_params)
    @event_id = params[:order][:event_id]
    #if Address.find(params[:order][:address_id]).blank? && @address.save!
      @order.user_id = current_user.id
    #else
      #render :new
    #end
    @order.postal_code = @address.postal_code
    @order.address = @address.full_address
    @order.username = @address.address_username
    
    # @entry = current_user.entries.all
    @entry = Entry.find_by(params[:entry_id])
    
    # if @order.save
    #   Entry.destroy_all
    #   # render :thanks
    # end
  end
  
  def thanks
  end
  
  def index
    @orders = Order.all
    if params[:id].present?
      @order = Order.find(params[:id])
      @order_details = @order.order_details
    else
      
    end
  end
  
  def show
    @orders = Order.all
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
  
end

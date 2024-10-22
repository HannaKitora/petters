class Public::AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_login_user

  def index
    @addresses = Address.where(user_id: current_user.id)
    @address = Address.new
  end
  
  def edit
    @address = Address.find(params[:id])
    
  end
  
  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = "You have updated address successfully!"
      redirect_to addresses_path
    end
  end
  
  private
  
  def address_params
    params.require(:address).permit(:postal_code, :addresss, :address_username)
  end
  
  def ensure_login_user
    unless user_signed_in?
      flash[:alert] = "ログインが必要です"
      redirect_to root_path
    end
  end
end
class Address < ApplicationRecord
  belongs_to :user
  
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :address_username, presence: true
  
  def full_address
    '〒' + postal_code + ' ' + address + ' ' + address_username
  end
  
  def self.set_address(select_address, address_id = nil, user, address_params)
    if select_address == "1"
      if Address.exists?
        # address = user.addresses.where(params[:id])
        @address = Address.where(address_params[:address_id])
        
      end
    elsif select_address == "2"
      address = user.addresses.new(address_params)
      address.save!
    end
    address
  end
end

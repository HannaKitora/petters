class Address < ApplicationRecord
  belongs_to :user
  
  def full_address
    # byebug
    if postal_code && address
      '〒' + postal_code + ' ' + address
    else
      'Address not available'
    end
    # address = [address].compact.join(", ")
    # address || "Address not available"
  end
  
  def self.set_address(select_address, address_id = nil, user, address_params)
    if select_address == "1"
      if Address.exists?
        address = user.addresses.find(address_id)
      end
    elsif select_address == "2"
      address = user.addresses.new(address_params)
    end
    address
  end
end

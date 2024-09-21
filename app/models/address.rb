class Address < ApplicationRecord
  belongs_to :user
  
  def full_address
    '〒' + postal_code + ' ' + address
  end
    
end

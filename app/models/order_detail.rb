class OrderDetail < ApplicationRecord
  
  belongs_to :order
  belongs_to :event
  
  
  
  #製作ステータス
    enum manufacture_status:
        {
          impossible_manufacture:0,
          waiting_manufacture:1,
          manufacturing:2,
          finish:3
        }
        
  # def subtotal
  #   self.price * self.amount
  # end
  


end

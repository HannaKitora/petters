class Entry < ApplicationRecord
  belongs_to :event
  belongs_to :user
  
  validates :user_id, uniqueness: {scope: :event_id}
  
  
  def subtotal
    event.with_tax_price * amount
  end
  
  
end
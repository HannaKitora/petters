class Entry < ApplicationRecord
  belongs_to :event
  has_many :users, dependent: :destroy
  
  def subtotal
    event.with_tax_price * amount
  end
end
class Kind < ApplicationRecord
  has_many :pets, dependent: :destroy
  
end

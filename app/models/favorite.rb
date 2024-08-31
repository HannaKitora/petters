class Favorite < ApplicationRecord
  
  belongs_to :user
  belongs_to :pet
  has_one :notification, as: :notifiable, dependent: :destroy
  validates :user_id, uniqueness: {scope: :pet_id}
  
  after_create do
    create_notification(user_id: pet.user_id)
  end
  
end

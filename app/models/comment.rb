class Comment < ApplicationRecord
  belongs_to :pet
  belongs_to :user
  has_one :notification, as: :notifiable, dependent: :destroy

  after_create do
    create_notification(user_id: pet.user_id)
  end
end

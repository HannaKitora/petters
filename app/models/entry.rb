class Entry < ApplicationRecord
  belongs_to :event
  has_one_attached :event
  has_many :user_id, dependent: :destroy
end

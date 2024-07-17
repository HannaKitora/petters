class Relationship < ApplicationRecord
  
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
  
  alias_attribute :user_id, :follower_id
  validates :user_id, presence: true
  # validates :follower_id, presence: true
end

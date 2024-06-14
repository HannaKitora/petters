class Pet < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  belongs_to :pet
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :image, presence: true

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg')
    else
      image
    end
  end
    
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
end
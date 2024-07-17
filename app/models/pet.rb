class Pet < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :name, presence: true
  validates :kind, presence: true
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
  
  def self.search_for(content, method)
    if method == 'perfect'
      Pet.where(name: content)
    elsif method == 'forward'
      Pet.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Pet.where('name LIKE ?', '%' + content)
    else
      Pet.where('name LIKE ?', '%' + content + '%')
    end
  end
  
  # def self.looks(search, word)
  #   if search == "perfect_match"
  #     @pet = Pet.where("name LIKE?","#{word}")
  #   elsif search == "forward_match"
  #     @pet = Pet.where("name LIKE?","#{word}%")
  #   elsif search == "backward_match"
  #     @pet = Pet.where("name LIKE?","%#{word}")
  #   elsif search == "partial_match"
  #     @pet = Pet.where("name LIKE?","%#{word}%")
  #   else
  #     @pet = Pet.all
  #   end
  # end
  
end
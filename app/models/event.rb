class Event < ApplicationRecord
  has_one_attached :image
  has_many :entries, dependent: :destroy
  validates :price, presence: true
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg')
    else
      image
    end
  end
  
  def with_tax_price
   (price * 1.1).floor
  end
  
  def self.search_for(content, method)
    if method == 'perfect'
      Event.where(name: content)
    elsif method == 'forward'
      Event.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Event.where('name LIKE ?', '%' + content)
    else
      Event.where('name LIKE ?', '%' + content + '%')
    end
  end
  
  # def self.looks(search, word)
  #   if search == "perfect_match"
  #     @event = Event.where("name LIKE?","#{word}")
  #   elsif search == "forward_match"
  #     @event = Event.where("name LIKE?","#{word}%")
  #   elsif search == "backward_match"
  #     @event = Event.where("name LIKE?","%#{word}")
  #   elsif search == "partial_match"
  #     @event = Event.where("name LIKE?","%#{word}%")
  #   else
  #     @event = Event.all
  #   end
  # end

end
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

end
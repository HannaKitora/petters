class Event < ApplicationRecord
  has_one_attached :image
  has_many :entries, dependent: :destroy
  validates :price, numericality: { only_integer: true }, presence: true 
  validates :date, presence: true
  
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
      Event.where(title: content)
    elsif method == 'forward'
      Event.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Event.where('name LIKE ?', '%' + content)
    else
      Event.where('name LIKE ?', '%' + content + '%')
    end
  end
  
  def total_amount(current_user)
    entries.where(user_id: current_user.id).sum(:amount) 
  end
  
  def total_price(current_user)
    price = 0
    entries.where(user_id: current_user.id).each do |entry|
      price += entry.amount * (entry.event.price + entry.event.price * 0.1)
    end
    price.to_i
  end
  
  def self.sort_by_date(ids)
     where(id: ids).where("date >= ?", Date.today).order(date: :asc)
  end
  
end
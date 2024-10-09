class Order < ApplicationRecord
  
  belongs_to :user
  has_many :order_details
  has_many :events, through: :order_details
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  
  #注文ステータス
  enum order_status: {wait_payment: 0, confirm_payment: 1, making: 2, preparing_ship: 3, finish_prepare: 4}

  
  
  # def get_image(width, height)
  #   unless image.attached?
  #     file_path = Rails.root.join('app/assets/images/no_image.jpg')
  #     image.attach(io: File.open(file_path), filename: 'default-image.jpg')
  #   else
  #     image
  #   end
  # end
  
  
end

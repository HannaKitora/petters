class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details
  has_many :events, through: :order_details

  validates :postal_code, presence: true
  validates :address, presence: true
  validates :username, presence: true

  enum payment_method: { credit_card: 0, transfer: 1 }

  # 注文ステータス
  enum order_status: { wait_payment: 0, confirm_payment: 1, making: 2, preparing_ship: 3, finish_prepare: 4 }
end

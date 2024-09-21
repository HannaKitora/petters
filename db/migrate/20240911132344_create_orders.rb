class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :username
      t.string :postal_code
      t.string :address
      t.integer :total_payment
      t.integer :payment_method
      t.integer :status
      t.timestamps
    end
  end
end

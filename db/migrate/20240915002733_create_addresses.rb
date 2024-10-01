class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.string :postal_code
      t.string :address
      t.string :address_username
      t.timestamps
    end
  end
end

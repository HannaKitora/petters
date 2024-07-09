class CreatePets < ActiveRecord::Migration[6.1]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :kind
      t.text :caption
      # t.integer :price
      t.integer :user_id

      t.timestamps
    end
  end
end

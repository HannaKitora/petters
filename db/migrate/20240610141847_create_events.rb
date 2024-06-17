class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :detail
      t.integer :user_id
      t.integer :price

      t.timestamps
    end
  end
end

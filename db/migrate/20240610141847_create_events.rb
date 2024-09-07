class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :detail
      t.integer :user_id
      t.integer :price
      t.integer :entry_id
      t.date :date

      t.timestamps
    end
  end
end

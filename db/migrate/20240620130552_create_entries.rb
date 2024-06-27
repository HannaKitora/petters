class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.integer :event_id
      t.integer :user_id
      t.integer :amount
      t.float :tax_included_price

      t.timestamps
    end
  end
end

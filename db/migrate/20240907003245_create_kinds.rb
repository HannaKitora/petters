class CreateKinds < ActiveRecord::Migration[6.1]
  def change
    create_table :kinds do |t|
      t.string :kind
      t.integer :pet_id

      t.timestamps
    end
  end
end

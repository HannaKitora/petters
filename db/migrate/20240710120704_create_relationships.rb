class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id
      # t.references :following, foreign_key: { to_table: :users }
      # t.references :follower, foreign_key: { to_table: :users }

      t.timestamps
      t.index [:follower_id, :followed_id], unique: true
    end
  end
end

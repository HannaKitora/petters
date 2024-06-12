class Comment < ApplicationRecord
  
  def change
    create_table :comments do |t|
      t.text :comment_content
      user_id:integer
      pets_id:integer
      t.timestamps
    end
  end
end

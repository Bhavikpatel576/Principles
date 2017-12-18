class CreateFollowingRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :following_relationships do |t|
      t.integer :follower_id, foreign_key: true, null: false
      t.integer :followed_user_id, foreign_key: true, null: false

      t.timestamps
    end
    add_index :following_relationships, :follower_id
    add_index :following_relationships, :followed_user_id
    add_index :following_relationships, %i[follower_id followed_user_id], name: :relationship_index
  end
end

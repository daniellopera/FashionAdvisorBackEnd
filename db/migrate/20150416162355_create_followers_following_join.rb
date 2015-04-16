class CreateFollowersFollowingJoin < ActiveRecord::Migration
  def up
    create_table :followers_following, :id => false do |t|
      t.integer "user_id"
      t.integer "following_id"
    end
    add_index :followers_following, ["user_id", "following_id"]
  end

  def down
    drop_table :followers_following
  end
end

class CreateOutfitsUsersJoin < ActiveRecord::Migration
  def up
    create_table :outfits_users do |t|
      t.integer :outfit_id
      t.integer :user_id
    end
    add_index :outfits_users, ["user_id", "outfit_id"]
  end

  def down
    drop_table :outfits_users
  end
end

class CreateOutfitsTagsJoin < ActiveRecord::Migration
  def up
    create_table :outfits_tags do |t|
      t.integer :tag_id
      t.integer :outfit_id
    end
    add_index :outfits_tags, ["tag_id", "outfit_id"]
  end

  def down
    drop_table :outfits_tags
  end
end

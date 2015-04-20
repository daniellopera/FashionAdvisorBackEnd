class AddLikesAndDislikesToOutfits < ActiveRecord::Migration
  def change
    add_column :outfits, :likes, :integer
    add_column :outfits, :dislikes, :integer
    remove_column :outfits, :rating
  end
end

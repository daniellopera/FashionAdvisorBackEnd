class AddOutfitIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :outfit_id, :integer
  end
end

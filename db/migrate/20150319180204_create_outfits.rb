class CreateOutfits < ActiveRecord::Migration
  def up
    create_table :outfits do |t|
      t.string :name
      t.string :description
      t.integer :rating
      t.integer :user_id

      t.timestamps null: false
    end
  end

  def down
    drop_table :outfits
  end
end

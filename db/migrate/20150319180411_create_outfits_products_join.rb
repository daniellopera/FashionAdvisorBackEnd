class CreateOutfitsProductsJoin < ActiveRecord::Migration
  def up
    create_table :outfits_products, id: false do |t|
      t.integer "outfit_id"
      t.integer "product_id"
    end
    add_index :outfits_products, ["outfit_id", "product_id"]
  end

  def down
    drop_table :outfits_products
  end
end

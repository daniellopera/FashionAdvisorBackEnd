class CreateFashionUpdates < ActiveRecord::Migration
  def up
    create_table :fashion_updates do |t|
      t.string :name
      t.string :image_url
      t.string :description
      t.timestamps null: false
    end
  end

  def down
    drop_table :fashion_updates
  end
end

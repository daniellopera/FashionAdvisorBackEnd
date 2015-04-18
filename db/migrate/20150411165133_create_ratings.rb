class CreateRatings < ActiveRecord::Migration
  def up
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :outfit_id
      t.boolean :rating
      t.timestamps null: false
    end

    def down
      drop_table :ratings
    end
  end
end

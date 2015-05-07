class CreateActivities < ActiveRecord::Migration
  def up
    create_table :activities do |t|
      t.integer :user_id
      t.integer :outfit_id
      t.string :type
      t.timestamps null: false
    end
  end

  def down
    drop_table :activities
  end
end

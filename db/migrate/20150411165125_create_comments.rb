class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :outfit_id
      t.timestamps null: false
    end
  end

  def down
    drop_table :comments
  end
end

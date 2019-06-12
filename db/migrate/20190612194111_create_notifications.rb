class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :sender_id
      t.text :body
      t.string :game
      t.integer :game_id
      t.integer :points

      t.timestamps
    end
  end
end

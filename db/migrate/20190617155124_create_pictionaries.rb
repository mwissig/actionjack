class CreatePictionaries < ActiveRecord::Migration[5.2]
  def change
    create_table :pictionaries do |t|
      t.integer :user_id
      t.datetime :last_online
      t.integer :current_score
      t.integer :all_time_score
      t.boolean :turn

      t.timestamps
    end
  end
end

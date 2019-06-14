class CreateGamechats < ActiveRecord::Migration[5.2]
  def change
    create_table :gamechats do |t|
      t.integer :user_id
      t.integer :game_id
      t.string :game_type
      t.text :body

      t.timestamps
    end
  end
end

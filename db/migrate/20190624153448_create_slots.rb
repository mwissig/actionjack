class CreateSlots < ActiveRecord::Migration[5.2]
  def change
    create_table :slots do |t|
      t.integer :jackpot
      t.integer :last_winner_id
      t.integer :last_win_prize
      t.datetime :last_win_date

      t.timestamps
    end
  end
end

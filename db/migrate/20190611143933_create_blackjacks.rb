class CreateBlackjacks < ActiveRecord::Migration[5.2]
  def change
    create_table :blackjacks do |t|
      t.integer :player_id
      t.string :room_name

      t.timestamps
    end
  end
end

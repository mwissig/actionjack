class AddColumnToSlot < ActiveRecord::Migration[5.2]
  def change
    add_column :slots, :biggest_prize, :integer
    add_column :slots, :biggest_winner_id, :integer
    add_column :slots, :biggest_win_date, :datetime
  end
end

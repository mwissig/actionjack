class Addturntotictactoe < ActiveRecord::Migration[5.2]
  def change
    add_column :tictactoes, :turn, :string
  end
end

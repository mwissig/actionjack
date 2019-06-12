class CreateTictactoes < ActiveRecord::Migration[5.2]
  def change
    create_table :tictactoes do |t|
      t.integer :x_id
      t.integer :o_id
      t.string :a1
      t.string :b1
      t.string :c1
      t.string :a2
      t.string :b2
      t.string :c2
      t.string :a3
      t.string :b3
      t.string :c3
      t.integer :x_wins
      t.integer :o_wins

      t.timestamps
    end
  end
end

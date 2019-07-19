class CreateMinetiles < ActiveRecord::Migration[5.2]
  def change
    create_table :minetiles do |t|
      t.integer :xcoord
      t.integer :ycoord
      t.string :coords
      t.string :bgclass
      t.string :fgclass

      t.timestamps
    end
  end
end
